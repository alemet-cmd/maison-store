#!/usr/bin/env python3
"""
Generate a Doofinder-compatible CSV product feed from js/store.js.
Run:  python3 generate_feed.py
"""

import csv
import json
import os
import re
import sys

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
STORE_JS = os.path.join(SCRIPT_DIR, "js", "store.js")
OUTPUT = os.path.join(SCRIPT_DIR, "DOOFINDER_FEED.csv")

BASE_URL = "http://localhost:8080"

CATEGORY_MAP = {
    "women": "Clothing > Women",
    "men": "Clothing > Men",
    "accessories": "Clothing > Accessories",
    "shoes": "Clothing > Shoes",
    "sale": "Clothing > Sale",
}

GENDER_MAP = {
    "women": "Women",
    "men": "Men",
    "accessories": "Unisex",
    "shoes": "Unisex",
}

COLORS = ["Black", "White", "Navy", "Beige", "Brown", "Grey", "Camel", "Ivory", "Red", "Green"]

SIZES_CLOTHING = ["XS", "S", "M", "L", "XL"]
SIZES_SHOES = ["36", "37", "38", "39", "40", "41", "42", "43"]


def js_value_to_python(val):
    """Convert a JS literal (string or number) to a Python value."""
    val = val.strip()
    if (val.startswith("'") and val.endswith("'")) or (val.startswith('"') and val.endswith('"')):
        inner = val[1:-1]
        inner = inner.replace("\\'", "'").replace('\\"', '"')
        return inner
    try:
        return int(val)
    except ValueError:
        return float(val)


def parse_products(js_src):
    """Extract the PRODUCTS array from store.js source."""
    # Grab everything between `const PRODUCTS = [` and the closing `];`
    m = re.search(r"const PRODUCTS\s*=\s*\[(.+?)\];", js_src, re.DOTALL)
    if not m:
        sys.exit("ERROR: Could not find PRODUCTS array in store.js")

    block = m.group(1)
    products = []

    # Match each { ... } object.  We split on the pattern `},` at line-end boundaries.
    for obj_match in re.finditer(r"\{([^}]+)\}", block):
        obj_body = obj_match.group(1)
        product = {}
        # Match key:'value' or key:number pairs
        for kv in re.finditer(r"(\w+)\s*:\s*('(?:[^'\\]|\\.)*'|\"(?:[^\"\\]|\\.)*\"|-?[\d.]+)", obj_body):
            key = kv.group(1)
            product[key] = js_value_to_python(kv.group(2))
        if "id" in product:
            products.append(product)

    return products


def parse_sale_map(js_src):
    """Extract the SALE_MAP object from store.js source."""
    m = re.search(r"const SALE_MAP\s*=\s*\{(.+?)\};", js_src, re.DOTALL)
    if not m:
        sys.exit("ERROR: Could not find SALE_MAP in store.js")

    sale_map = {}
    for kv in re.finditer(r"(\w+)\s*:\s*(-?[\d.]+)", m.group(1)):
        sale_map[kv.group(1)] = int(kv.group(2))
    return sale_map


def build_sale_products(products, sale_map):
    """Replicate the JS SALE_PRODUCTS logic."""
    by_id = {p["id"]: p for p in products}
    sale_products = []
    for pid, sale_price in sale_map.items():
        if pid not in by_id:
            continue
        sp = dict(by_id[pid])
        sp["salePrice"] = sale_price
        sp["original_slug"] = sp["slug"]  # remember original for gender
        sp["category"] = "Sale"
        sp["slug"] = "sale"
        sale_products.append(sp)
    return sale_products


def main():
    with open(STORE_JS, encoding="utf-8") as f:
        js_src = f.read()

    products = parse_products(js_src)
    sale_map = parse_sale_map(js_src)
    sale_products = build_sale_products(products, sale_map)
    all_products = products + sale_products

    # CSV columns
    columns = [
        "id", "title", "description", "link", "image_link",
        "price", "sale_price", "category", "availability",
        "group_id", "group_leader", "attributes",
    ]

    category_counts = {}

    with open(OUTPUT, "w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f, quoting=csv.QUOTE_ALL)
        writer.writerow(columns)

        for idx, p in enumerate(all_products):
            slug = p["slug"]
            original_slug = p.get("original_slug", slug)

            # Category path
            cat_path = CATEGORY_MAP.get(slug, f"Clothing > {p.get('category', 'Other')}")
            category_counts[cat_path] = category_counts.get(cat_path, 0) + 1

            # Gender
            gender = GENDER_MAP.get(original_slug, "Unisex")

            # Color — cycle by index
            color = COLORS[idx % len(COLORS)]

            # Size — depends on product type
            if original_slug in ("women", "men"):
                size = SIZES_CLOTHING[idx % len(SIZES_CLOTHING)]
            elif original_slug == "shoes":
                size = SIZES_SHOES[idx % len(SIZES_SHOES)]
            else:
                size = "One Size"

            attributes = f"color={color}/size={size}/gender={gender}"

            # Price fields
            price = f"{p['price']:.2f}"
            sale_price = f"{p['salePrice']:.2f}" if "salePrice" in p else ""

            # Product link
            pid = p["id"]
            link = f"{BASE_URL}/product/detail.html?id={pid}"

            row = [
                pid,
                p["name"],
                p.get("description", ""),
                link,
                p.get("image", ""),
                price,
                sale_price,
                cat_path,
                "in stock",
                pid,
                "true",
                attributes,
            ]
            writer.writerow(row)

    # Summary
    total = len(all_products)
    print(f"DOOFINDER_FEED.csv generated successfully!")
    print(f"  Saved to: {OUTPUT}")
    print(f"  Total products: {total}")
    print()
    print("  Products per category:")
    for cat in sorted(category_counts):
        print(f"    {cat}: {category_counts[cat]}")


if __name__ == "__main__":
    main()

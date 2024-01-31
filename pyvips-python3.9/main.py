#!/usr/local/bin/python

import sys
import pyvips

image = pyvips.Image.pdfload(sys.argv[1])
for i in range(image.get("n-pages")):
    page = pyvips.Image.thumbnail(sys.argv[1] + f"[page={i}]", 2048)[:3]
    page = page.gravity("centre", 2048, 2048, extend="white")
    data = page.write_to_buffer(".png")
    print(f"rendered page {i} as {len(data)} bytes of PNG")

#!/usr/bin/python3

import sys
import pyvips

for filename in sys.argv[1:]:
    thumb = pyvips.Image.thumbnail(filename, 600, height=200, size="both",
            crop="centre", import_profile="srgb", export_profile="srgb")
    data = thumb.write_to_memory()

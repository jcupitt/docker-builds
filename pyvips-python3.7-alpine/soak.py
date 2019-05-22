#!/usr/local/bin/python3

# usage: soak.py <test-image> <output-image>

import resource
import sys
import pyvips

pyvips.cache_set_max(0)

for i in range(10000):
    with open(sys.argv[1], "rb") as fh:
        img = pyvips.Image.new_from_buffer(fh.read(), "", access="sequential")

    kw = {
        "compression": "jpeg",
        "Q": 90,
        "tile": True,
        "tile_width": 256,
        "tile_height": 256,
        "pyramid": True,
        "bigtiff": True,
    }

    img.tiffsave(sys.argv[2], **kw)

    print("{}, {}"
        .format(i, resource.getrusage(resource.RUSAGE_SELF).ru_maxrss))

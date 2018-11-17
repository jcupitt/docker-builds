#!/usr/local/bin/python3

import sys
import pyvips

def wobble(image):
    # this makes an image where pixel (0, 0) (at the top-left) has value [0, 0],
    # and pixel (image.width, image.height) at the bottom-right has value
    # [image.width, image.height]
    index = pyvips.Image.xyz(image.width, image.height)

    # make a version with (0, 0) at the centre, negative values up and left,
    # positive down and right
    centre = index - [image.width / 2, image.height / 2]

    # to polar space, so each pixel is now distance and angle in degrees
    polar = centre.polar()

    # scale sin(distance) by 1/distance to make a wavey pattern
    d = 10000 * (polar[0] * 3).sin() / (1 + polar[0])

    # and back to rectangular coordinates again to make a set of vectors we can
    # apply to the original index image
    index += d.bandjoin(polar[1]).rect()

    # finally, use our modified index image to distort the input!
    return image.mapim(index)

image = pyvips.Image.new_from_file(sys.argv[1])
image = wobble(image)
image.write_to_file(sys.argv[2])

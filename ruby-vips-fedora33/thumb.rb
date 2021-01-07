#!/usr/bin/ruby

require 'vips'

x = Vips::Image.thumbnail("Gugg_coloured.jpg", 100, height: 100, 
                          **{crop: "centre", size: :down})
x.write_to_file("thumb.jpg")

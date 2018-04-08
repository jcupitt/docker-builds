#!/usr/bin/env php
<?php

require __DIR__ . '/vendor/autoload.php';
use Jcupitt\Vips;

$base = Vips\Image::newFromFile($argv[1], ["access" => "sequential"]);
$overlay = Vips\Image::newFromFile($argv[2], ["access" => "sequential"]);

// make the overlay the same size as the image, but centred and moved up 
// a bit
$left = ($base->width - $overlay->width) * 0.5;
$top = ($base->height - $overlay->height) * 0.45;
$overlay = $overlay->embed($left, $top, $base->width, $base->height);

$out = $base->composite2($overlay, "over");

// write to stdout with a mime header
//$out->jpegsave_mime();

// alternative: write to a file
$out->writeToFile($argv[3]);

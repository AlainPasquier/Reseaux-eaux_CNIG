#!/bin/bash
for file in *.svg
 do
  scour -i $file -o ../svg_nb_optim/$file
  inkscape $file -o ../PNG/${file%svg}png
 done

#!/usr/bin/env bash

rm ~/work/blog/assets/editTimeTacticsPoster.pdf
cp ./output.pdf ~/work/blog/assets/editTimeTacticsPoster.pdf
cd ~/work/blog
./deploy.sh
cd ~/latexmasters/poster

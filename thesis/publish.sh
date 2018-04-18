#!/usr/bin/env bash

rm ~/work/blog/assets/editTimeTacticsDraft.pdf
cp ./output.pdf ~/work/blog/assets/editTimeTacticsDraft.pdf
cd ~/work/blog
./deploy.sh
cd ~/latexmasters/thesis

#!/bin/bash
ORIGINAL_FOLDER=$(pwd)

cd ~/.config/nvim

ln -sF "${ORIGINAL_FOLDER}/lua" ./lua

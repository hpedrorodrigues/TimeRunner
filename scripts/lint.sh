#!/usr/bin/env bash

luacheck --no-unused-args \
  --std max+busted *.lua src \
  --no-cache \
  --ignore 512 \
  --globals IMPORTATIONS backgroundSound application \
  --read-globals system Runtime native transition timer graphics audio display

# busted --verbose --coverage
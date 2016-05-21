#!/usr/bin/env bash

luacheck --no-unused-args \
  --std max+busted *.lua src \
  --no-cache \
  --ignore 512 \
  --globals IMPORTATIONS backgroundSound application googleAnalytics \
  --read-globals system Runtime native transition timer graphics audio display collectgarbage

# busted --verbose --coverage
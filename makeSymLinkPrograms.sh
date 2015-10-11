#!/bin/sh
for file in *.lua; do ln $file ../${file%%.lua}; done

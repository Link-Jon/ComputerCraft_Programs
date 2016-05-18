#!/bin/sh
for file in *.lua; do 
	rm ../${file%%.lua}
	ln $file ../${file%%.lua}
done
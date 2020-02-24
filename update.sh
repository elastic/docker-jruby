#!/bin/sh

for i in $(ls); do
	if [ -d "$i" -a "${i}" != "tests" ] ; then
		echo updating versions for "$i"
		(
			cd $i
			./update.sh
			echo
		)
	fi
done

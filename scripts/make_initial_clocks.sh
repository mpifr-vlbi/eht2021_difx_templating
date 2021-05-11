#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
pushd $SCRIPT_DIR

# 230G
for expt in e21b09 e21e13 e21a14 e21d15 e21a17 e21e18; do
	for band in band1 band2 band3 band4; do
		clockfile=../templates/230G/$band/clocks_$expt.dat
		echo "Making empty $clockfile"
		echo "CLOCK" > $clockfile
		echo "# Station ID    Delay (usec)    Rate (usec)" >> $clockfile
	done
done

# 345G
for expt in e21f19; do
	for band in band1 band2 band3 band4; do
		clockfile=../templates/345G/$band/clocks_$expt.dat
		echo "Making empty $clockfile"
		echo "CLOCK" > $clockfile
		echo "# Station ID    Delay (usec)    Rate (usec)" >> $clockfile
	done
done

popd


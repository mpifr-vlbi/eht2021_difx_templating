#!/bin/bash
#
# Split sections of the VEX files under ../observed_vex/ into different files.
#

VEXDIR=../observed_vex/

function extract_vex_sections() {

	vexname=`basename $1`
	# sed -n "/\$SCHED;/,/^<eof>/p" $1 > sched_$vexname

	sed -n "/\$SOURCE;/,/\$FREQ;/p" $1 > sources_$vexname
	sed -i '$ d' sources_$vexname  # remove trailing $FREQ; line

}

for vexfile in `ls -1 $VEXDIR/*.vex`; do
	echo "Running extract_vex_sections $vexfile"
	extract_vex_sections $vexfile
done


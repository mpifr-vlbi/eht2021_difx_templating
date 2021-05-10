#!/bin/bash
#
# Split sections of the VEX files under ../observed_vex/ into different files.
#

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
VEXDIR=../observed_vex/
OUTDIR=../templates/common_sections/

pushd $SCRIPT_DIR

function extract_vex_sections() {

	vexname=`basename $1`
	sed -n "/\$SCHED;/,/^<eof>/p" $1 > $OUTDIR/sched_$vexname

	sed -n "/\$SOURCE;/,/\$FREQ;/p" $1 > $OUTDIR/sources_$vexname
	sed -i '$ d' $OUTDIR/sources_$vexname  # remove trailing $FREQ; line
}

for vexfile in `ls -1 $VEXDIR/*.vex`; do
	echo "Running extract_vex_sections $vexfile"
	extract_vex_sections $vexfile
done


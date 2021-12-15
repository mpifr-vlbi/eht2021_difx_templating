#!/bin/bash
#
# e21b09.vex:     exper_nominal_start=2021y098d23h52m00s;
# e21e13.vex:     exper_nominal_start=2021y102d19h40m00s;
# e21a14.vex:     exper_nominal_start=2021y103d23h40m00s;
# e21d15.vex:     exper_nominal_start=2021y104d23h29m00s;
# e21a16.vex:     exper_nominal_start=2021y105d23h32m00s;
# e21a17.vex:     exper_nominal_start=2021y106d23h28m00s;
# e21e18.vex:     exper_nominal_start=2021y107d19h20m00s;
# e21f19.vex:     exper_nominal_start=2021y109d01h13m00s;

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
OUTDIR=../templates/common_sections/

pushd $SCRIPT_DIR

./geteop.pl 2021-98  5 $OUTDIR/eop_e21b09.vex
./geteop.pl 2021-102 5 $OUTDIR/eop_e21e13.vex
./geteop.pl 2021-103 5 $OUTDIR/eop_e21a14.vex
./geteop.pl 2021-104 5 $OUTDIR/eop_e21d15.vex
./geteop.pl 2021-105 5 $OUTDIR/eop_e21a16.vex
./geteop.pl 2021-106 5 $OUTDIR/eop_e21a17.vex
./geteop.pl 2021-107 5 $OUTDIR/eop_e21e18.vex
./geteop.pl 2021-109 5 $OUTDIR/eop_e21f19.vex

popd


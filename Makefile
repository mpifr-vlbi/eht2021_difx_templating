
include Makefile.inc

.NOTPARALLEL:

default:

preqrequisites:
	. scripts/create_vex_EOPs.sh
	. scripts/extract_vex_portions.sh
	. scripts/make_initial_clocks.sh
	./scripts/noema-vex-defs.py --lo1 221.100 --lo2 7.744 -r 1   > templates/230G/band1/freqs_NOEMA.vex
	./scripts/noema-vex-defs.py --lo1 221.100 --lo2 7.744 -r 1,2 > templates/230G/band2/freqs_NOEMA.vex
	./scripts/noema-vex-defs.py --lo1 221.100 --lo2 7.744 -r 3,4 > templates/230G/band3/freqs_NOEMA.vex
	./scripts/noema-vex-defs.py --lo1 221.100 --lo2 7.744 -r 3   > templates/230G/band4/freqs_NOEMA.vex
	./scripts/alma-vex-defs.py --lo1 221.100 -r 1 > templates/230G/band1/freqs_ALMA.vex
	./scripts/alma-vex-defs.py --lo1 221.100 -r 2 > templates/230G/band2/freqs_ALMA.vex
	./scripts/alma-vex-defs.py --lo1 221.100 -r 3 > templates/230G/band3/freqs_ALMA.vex
	./scripts/alma-vex-defs.py --lo1 221.100 -r 4 > templates/230G/band4/freqs_ALMA.vex

####################################################################################
## Build and install full correlation v2d vex config sets
####################################################################################

EHT_2021_230GHz_all: EHT_2021_230GHz_b1 EHT_2021_230GHz_b2 EHT_2021_230GHz_b3 EHT_2021_230GHz_b4

EHT_2021_345GHz_all: EHT_2021_345GHz_b1 EHT_2021_345GHz_b2 EHT_2021_345GHz_b3 EHT_2021_345GHz_b4

all: EHT_2021_230GHz_all EHT_2021_345GHz_all

EHT_2021_230GHz_b1: e21b09_b1 e21e13_b1 e21a14_b1 e21d15_b1 e21a17_b1 e21e18_b1

EHT_2021_230GHz_b2: e21b09_b2 e21e13_b2 e21a14_b2 e21d15_b2 e21a17_b2 e21e18_b2

EHT_2021_230GHz_b3: e21b09_b3 e21e13_b3 e21a14_b3 e21d15_b3 e21a17_b3 e21e18_b3

EHT_2021_230GHz_b4: e21b09_b4 e21e13_b4 e21a14_b4 e21d15_b4 e21a17_b4 e21e18_b4

EHT_2021_345GHz_b1: e21f19_b1

EHT_2021_345GHz_b2: e21f19_b2

EHT_2021_345GHz_b3: e21f19_b3

EHT_2021_345GHz_b4: e21f19_b4

# install: install_b1 install_b4
# diff: diff_b1 diff_b4

####################################################################################
## EHT 2021 -- Band 1
####################################################################################

b1: EHT_2021_230GHz_b1 EHT_2021_345GHz_b1

e21b09_b1:
	./tvex2vex.py -I./templates/230G/band1/ -I./templates/common_sections/ templates/e21b09.vext out/e21b09-$(REL)-b1.vex.obs
	./tvex2vex.py -I./templates/230G/band1/ -I./templates/common_sections/ templates/e21b09.v2dt out/e21b09-$(REL)-b1.v2d
	sed -i "s/vexfilename/e21b09-${REL}-b1.vex.obs/g" out/e21b09-$(REL)-b1.v2d

e21e13_b1:

e21a14_b1:

e21d15_b1:

e21a17_b1:

e21e18_b1:

e21f19_b1:

####################################################################################
## EHT 2021 -- Band 2
####################################################################################

b2: EHT_2021_230GHz_b2 EHT_2021_345GHz_b2

e21b09_b2:

e21e13_b2:

e21a14_b2:

e21d15_b2:

e21a17_b2:

e21e18_b2:

e21f19_b2:

####################################################################################
## EHT 2021 -- Band 3
####################################################################################

b3: EHT_2021_230GHz_b3 EHT_2021_345GHz_b3

e21b09_b3:

e21e13_b3:

e21a14_b3:

e21d15_b3:

e21a17_b3:

e21e18_b3:

e21f19_b3:

####################################################################################
## EHT 2021 -- Band 4
####################################################################################

b4: EHT_2021_230GHz_b4 EHT_2021_345GHz_b4

e21b09_b4:

e21e13_b4:

e21a14_b4:

e21d15_b4:

e21a17_b4:

e21e18_b4:

e21f19_b4:

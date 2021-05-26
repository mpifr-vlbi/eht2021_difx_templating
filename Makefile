
include Makefile.inc

default: all

prerequisites:
	mkdir -p out
	. scripts/create_vex_EOPs.sh
	. scripts/extract_vex_portions.sh
	. scripts/make_initial_clocks.sh
	. scripts/make_initial_notes.sh
	# ./scripts/noema-vex-defs.py --lo1 221.100 --lo2 7.744 -r 1,2 > templates/230G/band2/freqs_NOEMA.vex # commented out after decision 5/2021 to ignore the 4x64 MHz overlap of b2 into recorder1
	# ./scripts/noema-vex-defs.py --lo1 221.100 --lo2 7.744 -r 3,4 > templates/230G/band3/freqs_NOEMA.vex
	## 230G
	./scripts/noema-vex-defs.py --lo1 221.100 --lo2 7.744 -r 1   > templates/230G/band1/freqs_NOEMA.vex
	./scripts/noema-vex-defs.py --lo1 221.100 --lo2 7.744 -r 2   > templates/230G/band2/freqs_NOEMA.vex
	./scripts/noema-vex-defs.py --lo1 221.100 --lo2 7.744 -r 4   > templates/230G/band3/freqs_NOEMA.vex
	./scripts/noema-vex-defs.py --lo1 221.100 --lo2 7.744 -r 3   > templates/230G/band4/freqs_NOEMA.vex
	./scripts/alma-vex-defs.py --lo1 221.100 -r 1 > templates/230G/band1/freqs_ALMA.vex
	./scripts/alma-vex-defs.py --lo1 221.100 -r 2 > templates/230G/band2/freqs_ALMA.vex
	./scripts/alma-vex-defs.py --lo1 221.100 -r 3 > templates/230G/band3/freqs_ALMA.vex
	./scripts/alma-vex-defs.py --lo1 221.100 -r 4 > templates/230G/band4/freqs_ALMA.vex
	## 345G
	./scripts/noema-vex-defs.py --lo1 342.600 --lo2 7.744 -r 1   > templates/345G/band1/freqs_NOEMA.vex
	./scripts/noema-vex-defs.py --lo1 342.600 --lo2 7.744 -r 2   > templates/345G/band2/freqs_NOEMA.vex
	./scripts/noema-vex-defs.py --lo1 342.600 --lo2 7.744 -r 4   > templates/345G/band3/freqs_NOEMA.vex
	./scripts/noema-vex-defs.py --lo1 342.600 --lo2 7.744 -r 3   > templates/345G/band4/freqs_NOEMA.vex
	./scripts/alma-vex-defs.py --lo1 342.600 -r 1 > templates/345G/band1/freqs_ALMA.vex
	./scripts/alma-vex-defs.py --lo1 342.600 -r 2 > templates/345G/band2/freqs_ALMA.vex
	./scripts/alma-vex-defs.py --lo1 342.600 -r 3 > templates/345G/band3/freqs_ALMA.vex
	./scripts/alma-vex-defs.py --lo1 342.600 -r 4 > templates/345G/band4/freqs_ALMA.vex

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

install: install_b1 install_b2 install_b3 install_b4

# diff: diff_b1 diff_b4

####################################################################################
## EHT 2021 -- Band 1
####################################################################################

b1: EHT_2021_230GHz_b1 EHT_2021_345GHz_b1

e21b09_b1:
	@ ./tvex2vex.py -I./templates/230G/band1/ -I./templates/common_sections/ templates/e21b09.vext out/e21b09-$(REL)-b1.vex.obs
	@ ./tvex2vex.py -I./templates/230G/band1/ -I./templates/common_sections/ templates/e21b09.v2dt out/e21b09-$(REL)-b1.v2d
	@ sed -i "s/vexfilename/e21b09-${REL}-b1.vex.obs/g" out/e21b09-$(REL)-b1.v2d

e21e13_b1:
	@ ./tvex2vex.py -I./templates/230G/band1/ -I./templates/common_sections/ templates/e21e13.vext out/e21e13-$(REL)-b1.vex.obs
	@ ./tvex2vex.py -I./templates/230G/band1/ -I./templates/common_sections/ templates/e21e13.v2dt out/e21e13-$(REL)-b1.v2d
	@ sed -i "s/vexfilename/e21e13-${REL}-b1.vex.obs/g" out/e21e13-$(REL)-b1.v2d

e21a14_b1:
	@ ./tvex2vex.py -I./templates/230G/band1/ -I./templates/common_sections/ templates/e21a14.vext out/e21a14-$(REL)-b1.vex.obs
	@ ./tvex2vex.py -I./templates/230G/band1/ -I./templates/common_sections/ templates/e21a14.v2dt out/e21a14-$(REL)-b1.v2d
	@ sed -i "s/vexfilename/e21a14-${REL}-b1.vex.obs/g" out/e21a14-$(REL)-b1.v2d

e21d15_b1:
	@ ./tvex2vex.py -I./templates/230G/band1/ -I./templates/common_sections/ templates/e21d15.vext out/e21d15-$(REL)-b1.vex.obs
	@ ./tvex2vex.py -I./templates/230G/band1/ -I./templates/common_sections/ templates/e21d15.v2dt out/e21d15-$(REL)-b1.v2d
	@ sed -i "s/vexfilename/e21d15-${REL}-b1.vex.obs/g" out/e21d15-$(REL)-b1.v2d

e21a17_b1:
	@ ./tvex2vex.py -I./templates/230G/band1/ -I./templates/common_sections/ templates/e21a17.vext out/e21a17-$(REL)-b1.vex.obs
	@ ./tvex2vex.py -I./templates/230G/band1/ -I./templates/common_sections/ templates/e21a17.v2dt out/e21a17-$(REL)-b1.v2d
	@ sed -i "s/vexfilename/e21a17-${REL}-b1.vex.obs/g" out/e21a17-$(REL)-b1.v2d

e21e18_b1:
	@ ./tvex2vex.py -I./templates/230G/band1/ -I./templates/common_sections/ templates/e21e18.vext out/e21e18-$(REL)-b1.vex.obs
	@ ./tvex2vex.py -I./templates/230G/band1/ -I./templates/common_sections/ templates/e21e18.v2dt out/e21e18-$(REL)-b1.v2d
	@ sed -i "s/vexfilename/e21e18-${REL}-b1.vex.obs/g" out/e21e18-$(REL)-b1.v2d

e21f19_b1:
	@ touch out/e21f19-$(REL)-b1.v2d
	@ touch out/e21f19-$(REL)-b1.vex.obs
	@echo "Generated blank v2d and vex.obs for e21f19 b1. ToDo: 345G templates!"

install_b1:
	for exptname in e21b09 e21e13 e21a14 e21d15 e21a17 e21e18 e21f19; do \
		mkdir -p $(EXPROOT)/$${exptname}/$(REV)/b1/ ; \
		cp -av out/$${exptname}-${REL}-b1.{v2d,vex.obs} $(EXPROOT)/$${exptname}/$(REV)/b1/ ; \
	done

####################################################################################
## EHT 2021 -- Band 2
####################################################################################

b2: EHT_2021_230GHz_b2 EHT_2021_345GHz_b2

e21b09_b2:
	@ ./tvex2vex.py -I./templates/230G/band2/ -I./templates/common_sections/ templates/e21b09.vext out/e21b09-$(REL)-b2.vex.obs
	@ ./tvex2vex.py -I./templates/230G/band2/ -I./templates/common_sections/ templates/e21b09.v2dt out/e21b09-$(REL)-b2.v2d
	@ sed -i "s/vexfilename/e21b09-${REL}-b2.vex.obs/g" out/e21b09-$(REL)-b2.v2d

e21e13_b2:
	@ ./tvex2vex.py -I./templates/230G/band2/ -I./templates/common_sections/ templates/e21e13.vext out/e21e13-$(REL)-b2.vex.obs
	@ ./tvex2vex.py -I./templates/230G/band2/ -I./templates/common_sections/ templates/e21e13.v2dt out/e21e13-$(REL)-b2.v2d
	@ sed -i "s/vexfilename/e21e13-${REL}-b2.vex.obs/g" out/e21e13-$(REL)-b2.v2d

e21a14_b2:
	@ ./tvex2vex.py -I./templates/230G/band2/ -I./templates/common_sections/ templates/e21a14.vext out/e21a14-$(REL)-b2.vex.obs
	@ ./tvex2vex.py -I./templates/230G/band2/ -I./templates/common_sections/ templates/e21a14.v2dt out/e21a14-$(REL)-b2.v2d
	@ sed -i "s/vexfilename/e21a14-${REL}-b2.vex.obs/g" out/e21a14-$(REL)-b2.v2d

e21d15_b2:
	@ ./tvex2vex.py -I./templates/230G/band2/ -I./templates/common_sections/ templates/e21d15.vext out/e21d15-$(REL)-b2.vex.obs
	@ ./tvex2vex.py -I./templates/230G/band2/ -I./templates/common_sections/ templates/e21d15.v2dt out/e21d15-$(REL)-b2.v2d
	@ sed -i "s/vexfilename/e21d15-${REL}-b2.vex.obs/g" out/e21d15-$(REL)-b2.v2d

e21a17_b2:
	@ ./tvex2vex.py -I./templates/230G/band2/ -I./templates/common_sections/ templates/e21a17.vext out/e21a17-$(REL)-b2.vex.obs
	@ ./tvex2vex.py -I./templates/230G/band2/ -I./templates/common_sections/ templates/e21a17.v2dt out/e21a17-$(REL)-b2.v2d
	@ sed -i "s/vexfilename/e21a17-${REL}-b2.vex.obs/g" out/e21a17-$(REL)-b2.v2d

e21e18_b2:
	@ ./tvex2vex.py -I./templates/230G/band2/ -I./templates/common_sections/ templates/e21e18.vext out/e21e18-$(REL)-b2.vex.obs
	@ ./tvex2vex.py -I./templates/230G/band2/ -I./templates/common_sections/ templates/e21e18.v2dt out/e21e18-$(REL)-b2.v2d
	@ sed -i "s/vexfilename/e21e18-${REL}-b2.vex.obs/g" out/e21e18-$(REL)-b2.v2d

e21f19_b2:
	@ touch out/e21f19-$(REL)-b2.v2d
	@ touch out/e21f19-$(REL)-b2.vex.obs
	@echo "Generated blank v2d and vex.obs for e21f19 b2. ToDo: 345G templates!"

install_b2:
	for exptname in e21b09 e21e13 e21a14 e21d15 e21a17 e21e18 e21f19; do \
		mkdir -p $(EXPROOT)/$${exptname}/$(REV)/b2/ ; \
		cp -av out/$${exptname}-${REL}-b2.{v2d,vex.obs} $(EXPROOT)/$${exptname}/$(REV)/b2/ ; \
	done

####################################################################################
## EHT 2021 -- Band 3
####################################################################################

b3: EHT_2021_230GHz_b3 EHT_2021_345GHz_b3

e21b09_b3:
	@ ./tvex2vex.py -I./templates/230G/band3/ -I./templates/common_sections/ templates/e21b09.vext out/e21b09-$(REL)-b3.vex.obs
	@ ./tvex2vex.py -I./templates/230G/band3/ -I./templates/common_sections/ templates/e21b09.v2dt out/e21b09-$(REL)-b3.v2d
	@ sed -i "s/vexfilename/e21b09-${REL}-b3.vex.obs/g" out/e21b09-$(REL)-b3.v2d

e21e13_b3:
	@ ./tvex2vex.py -I./templates/230G/band3/ -I./templates/common_sections/ templates/e21e13.vext out/e21e13-$(REL)-b3.vex.obs
	@ ./tvex2vex.py -I./templates/230G/band3/ -I./templates/common_sections/ templates/e21e13.v2dt out/e21e13-$(REL)-b3.v2d
	@ sed -i "s/vexfilename/e21e13-${REL}-b3.vex.obs/g" out/e21e13-$(REL)-b3.v2d

e21a14_b3:
	@ ./tvex2vex.py -I./templates/230G/band3/ -I./templates/common_sections/ templates/e21a14.vext out/e21a14-$(REL)-b3.vex.obs
	@ ./tvex2vex.py -I./templates/230G/band3/ -I./templates/common_sections/ templates/e21a14.v2dt out/e21a14-$(REL)-b3.v2d
	@ sed -i "s/vexfilename/e21a14-${REL}-b3.vex.obs/g" out/e21a14-$(REL)-b3.v2d

e21d15_b3:
	@ ./tvex2vex.py -I./templates/230G/band3/ -I./templates/common_sections/ templates/e21d15.vext out/e21d15-$(REL)-b3.vex.obs
	@ ./tvex2vex.py -I./templates/230G/band3/ -I./templates/common_sections/ templates/e21d15.v2dt out/e21d15-$(REL)-b3.v2d
	@ sed -i "s/vexfilename/e21d15-${REL}-b3.vex.obs/g" out/e21d15-$(REL)-b3.v2d

e21a17_b3:
	@ ./tvex2vex.py -I./templates/230G/band3/ -I./templates/common_sections/ templates/e21a17.vext out/e21a17-$(REL)-b3.vex.obs
	@ ./tvex2vex.py -I./templates/230G/band3/ -I./templates/common_sections/ templates/e21a17.v2dt out/e21a17-$(REL)-b3.v2d
	@ sed -i "s/vexfilename/e21a17-${REL}-b3.vex.obs/g" out/e21a17-$(REL)-b3.v2d

e21e18_b3:
	@ ./tvex2vex.py -I./templates/230G/band3/ -I./templates/common_sections/ templates/e21e18.vext out/e21e18-$(REL)-b3.vex.obs
	@ ./tvex2vex.py -I./templates/230G/band3/ -I./templates/common_sections/ templates/e21e18.v2dt out/e21e18-$(REL)-b3.v2d
	@ sed -i "s/vexfilename/e21e18-${REL}-b3.vex.obs/g" out/e21e18-$(REL)-b3.v2d

e21f19_b3:
	@ touch out/e21f19-$(REL)-b3.v2d
	@ touch out/e21f19-$(REL)-b3.vex.obs
	@echo "Generated blank v2d and vex.obs for e21f19 b3. ToDo: 345G templates!"

install_b3:
	for exptname in e21b09 e21e13 e21a14 e21d15 e21a17 e21e18 e21f19; do \
		mkdir -p $(EXPROOT)/$${exptname}/$(REV)/b3/ ; \
		cp -av out/$${exptname}-${REL}-b3.{v2d,vex.obs} $(EXPROOT)/$${exptname}/$(REV)/b3/ ; \
	done

####################################################################################
## EHT 2021 -- Band 4
####################################################################################

b4: EHT_2021_230GHz_b4 EHT_2021_345GHz_b4

e21b09_b4:
	@ ./tvex2vex.py -I./templates/230G/band4/ -I./templates/common_sections/ templates/e21b09.vext out/e21b09-$(REL)-b4.vex.obs
	@ ./tvex2vex.py -I./templates/230G/band4/ -I./templates/common_sections/ templates/e21b09.v2dt out/e21b09-$(REL)-b4.v2d
	@ sed -i "s/vexfilename/e21b09-${REL}-b4.vex.obs/g" out/e21b09-$(REL)-b4.v2d

e21e13_b4:
	@ ./tvex2vex.py -I./templates/230G/band4/ -I./templates/common_sections/ templates/e21e13.vext out/e21e13-$(REL)-b4.vex.obs
	@ ./tvex2vex.py -I./templates/230G/band4/ -I./templates/common_sections/ templates/e21e13.v2dt out/e21e13-$(REL)-b4.v2d
	@ sed -i "s/vexfilename/e21e13-${REL}-b4.vex.obs/g" out/e21e13-$(REL)-b4.v2d

e21a14_b4:
	@ ./tvex2vex.py -I./templates/230G/band4/ -I./templates/common_sections/ templates/e21a14.vext out/e21a14-$(REL)-b4.vex.obs
	@ ./tvex2vex.py -I./templates/230G/band4/ -I./templates/common_sections/ templates/e21a14.v2dt out/e21a14-$(REL)-b4.v2d
	@ sed -i "s/vexfilename/e21a14-${REL}-b4.vex.obs/g" out/e21a14-$(REL)-b4.v2d

e21d15_b4:
	@ ./tvex2vex.py -I./templates/230G/band4/ -I./templates/common_sections/ templates/e21d15.vext out/e21d15-$(REL)-b4.vex.obs
	@ ./tvex2vex.py -I./templates/230G/band4/ -I./templates/common_sections/ templates/e21d15.v2dt out/e21d15-$(REL)-b4.v2d
	@ sed -i "s/vexfilename/e21d15-${REL}-b4.vex.obs/g" out/e21d15-$(REL)-b4.v2d

e21a17_b4:
	@ ./tvex2vex.py -I./templates/230G/band4/ -I./templates/common_sections/ templates/e21a17.vext out/e21a17-$(REL)-b4.vex.obs
	@ ./tvex2vex.py -I./templates/230G/band4/ -I./templates/common_sections/ templates/e21a17.v2dt out/e21a17-$(REL)-b4.v2d
	@ sed -i "s/vexfilename/e21a17-${REL}-b4.vex.obs/g" out/e21a17-$(REL)-b4.v2d

e21e18_b4:
	@ ./tvex2vex.py -I./templates/230G/band4/ -I./templates/common_sections/ templates/e21e18.vext out/e21e18-$(REL)-b4.vex.obs
	@ ./tvex2vex.py -I./templates/230G/band4/ -I./templates/common_sections/ templates/e21e18.v2dt out/e21e18-$(REL)-b4.v2d
	@ sed -i "s/vexfilename/e21e18-${REL}-b4.vex.obs/g" out/e21e18-$(REL)-b4.v2d

e21f19_b4:
	@ touch out/e21f19-$(REL)-b4.v2d
	@ touch out/e21f19-$(REL)-b4.vex.obs
	@echo "Generated blank v2d and vex.obs for e21f19 b4. ToDo: 345G templates!"

install_b4:
	for exptname in e21b09 e21e13 e21a14 e21d15 e21a17 e21e18 e21f19; do \
		mkdir -p $(EXPROOT)/$${exptname}/$(REV)/b4/ ; \
		cp -av out/$${exptname}-${REL}-b4.{v2d,vex.obs} $(EXPROOT)/$${exptname}/$(REV)/b4/ ; \
	done

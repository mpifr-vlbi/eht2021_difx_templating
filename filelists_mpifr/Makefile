
M6DIRS := /cluster/difx/directories/

all:
	@echo "Options:  'make bonn'  or  'make hays'"

map = sed -e 's/^/\/$(1)_fuse\/$(2)//' $(M6DIRS)/$(3).filelist

bonn: pv_b1 pv_b4

hays: pv_b2 pv_b3

pv_b1: # MPI%8009 MPI%8004, MPI%8002 MPI%8014 ; Bonn mark6-09
	sed -e 's/^/\/mark6-09_fuse\/12\//' $(M6DIRS)/MPI%8009.filelist > ehtc2021_Pico_set1_b1.12.filelist
	sed -e 's/^/\/mark6-09_fuse\/34\//' $(M6DIRS)/MPI%8002.filelist > ehtc2021_Pico_set1_b1.34.filelist

pv_b2:

pv_b3:

pv_b4: # SAO%0046 SAO%0018, SAO%0047 SAO%0049 ; Bonn mark6-10
	sed -e 's/^/\/mark6-10_fuse\/12\//' $(M6DIRS)/SAO%0046.filelist > ehtc2021_Pico_set1_b4.12.filelist
	sed -e 's/^/\/mark6-10_fuse\/34\//' $(M6DIRS)/SAO%0047.filelist > ehtc2021_Pico_set1_b4.34.filelist

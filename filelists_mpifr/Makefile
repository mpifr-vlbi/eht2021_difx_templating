
M6DIRS := /cluster/difx/directories/

all:
	@echo "Options:  'make bonn'  or  'make hays'"

mk6dir2filelist = sed -e 's/^/\/$(1)_fuse\/$(2)\//' $(M6DIRS)/$(3).filelist | cut -d' ' -f 1,2,3 > $(4)

bonn: pv_b1 pv_b4

hays: pv_b2 pv_b3

pv_b1: # MPI%8009 MPI%8004, MPI%8002 MPI%8014 ; Bonn mark6-09
	$(call mk6dir2filelist,mark6-09,12,MPI%8009,ehtc2021_Pico_set1_b1.12.filelist)
	$(call mk6dir2filelist,mark6-09,34,MPI%8002,ehtc2021_Pico_set1_b1.34.filelist)

pv_b2:

pv_b3:

pv_b4: # SAO%0046 SAO%0018, SAO%0047 SAO%0049 ; Bonn mark6-10
	$(call mk6dir2filelist,mark6-10,12,SAO%0046,ehtc2021_Pico_set1_b4.12.filelist)
	$(call mk6dir2filelist,mark6-10,34,SAO%0047,ehtc2021_Pico_set1_b4.34.filelist)

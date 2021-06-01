
M6DIRS := /cluster/difx/directories/

all:
	@echo "Options:  'make bonn'  or  'make hays'"

mk6dir2filelist = sed -e 's/^/\/$(1)_fuse\/$(2)\//' $(M6DIRS)/$(3).filelist | cut -d' ' -f 1,2,3 | grep e21 > $(4)

bonn: pv_b1 pv_b4 nn_b1 nn_b4 gl_b1 gl_b4

hays: pv_b2 pv_b3

## Pico

pv_b1: # MPI%8009 MPI%8004, MPI%8002 MPI%8014 ; Bonn mark6-09
	$(call mk6dir2filelist,mark6-09,12,MPI%8009,ehtc2021_Pico_set1_b1.12.filelist)
	$(call mk6dir2filelist,mark6-09,34,MPI%8002,ehtc2021_Pico_set1_b1.34.filelist)

pv_b2:

pv_b3:

pv_b4: # SAO%0046 SAO%0018, SAO%0047 SAO%0049 ; Bonn mark6-10
	$(call mk6dir2filelist,mark6-10,12,SAO%0046,ehtc2021_Pico_set1_b4.12.filelist)
	$(call mk6dir2filelist,mark6-10,34,SAO%0047,ehtc2021_Pico_set1_b4.34.filelist)

## NOEMA
	
nn_b1: # IRAM%009 %010 %011 %012 recorder1=b1
	$(call mk6dir2filelist,mark6-04,1,IRAM%009,ehtc2021_pNOEMA_set1_rec1.1.filelist)
	$(call mk6dir2filelist,mark6-04,2,IRAM%010,ehtc2021_pNOEMA_set1_rec1.2.filelist)
	$(call mk6dir2filelist,mark6-04,3,IRAM%011,ehtc2021_pNOEMA_set1_rec1.3.filelist)
	$(call mk6dir2filelist,mark6-04,4,IRAM%012,ehtc2021_pNOEMA_set1_rec1.4.filelist)

nn_b4: # IRAM%013 %014 %015 %016 recorder3(!)=b4
	$(call mk6dir2filelist,mark6-04,1,IRAM%013,ehtc2021_pNOEMA_set1_rec3.1.filelist)
	$(call mk6dir2filelist,mark6-04,2,IRAM%014,ehtc2021_pNOEMA_set1_rec3.2.filelist)
	$(call mk6dir2filelist,mark6-04,3,IRAM%015,ehtc2021_pNOEMA_set1_rec3.3.filelist)
	$(call mk6dir2filelist,mark6-04,4,IRAM%016,ehtc2021_pNOEMA_set1_rec3.4.filelist)

## GLT

gl_b1: # BHC%0172/173/174/175 recorder=?? ; Bonn mark6-11
	$(call mk6dir2filelist,mark6-11,12,BHC%0172,ehtc2021_GLT_set1_b1.12.filelist)
	$(call mk6dir2filelist,mark6-11,34,BHC%0174,ehtc2021_GLT_set1_b1.34.filelist)

gl_b4: # BHC%0164/165/166/167 recorder=?? ; Bonn mark6-11
	$(call mk6dir2filelist,mark6-11,12,BHC%0164,ehtc2021_GLT_set1_b4.12.filelist)
	$(call mk6dir2filelist,mark6-11,34,BHC%0166,ehtc2021_GLT_set1_b4.34.filelist)

buglist:
	# All scans that have unexpected time stamps
	grep -v " 59" ehtc2021_*.filelist

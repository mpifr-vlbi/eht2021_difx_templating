## Get global settings; REV (v0), REL (0), SITE (mpifr), EXPROOT (/Exps)
include ../Makefile.inc

M6DIRS := /cluster/difx/directories/

all:
	@echo "Options:  'make bonn'  or  'make hays'"

mk6dir2filelist = sed -e 's/^/\/$(1)_fuse\/$(2)\//' $(M6DIRS)/$(3).filelist | cut -d' ' -f 1,2,3 | grep e21 > $(4)

bonn: pv_b1 pv_b4 nn_b1 nn_b4 gl_b1 gl_b4 mg_b1 kt_b1 kt_b4 aa_b1 sw_b1 sw_b4 sz_b1 sz_b4 ax_b1 ax_b4 mm_b1 mm_b4

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
	$(call mk6dir2filelist,mark6-09,1,IRAM%013,ehtc2021_pNOEMA_set1_rec3.1.filelist)
	$(call mk6dir2filelist,mark6-09,2,IRAM%014,ehtc2021_pNOEMA_set1_rec3.2.filelist)
	$(call mk6dir2filelist,mark6-09,3,IRAM%015,ehtc2021_pNOEMA_set1_rec3.3.filelist)
	$(call mk6dir2filelist,mark6-09,4,IRAM%016,ehtc2021_pNOEMA_set1_rec3.4.filelist)

## GLT

gl_b1: # BHC%0172/173/174/175 recorder=?? ; Bonn mark6-11
	$(call mk6dir2filelist,mark6-11,12,BHC%0172,ehtc2021_GLT_set1_b1.12.filelist)
	$(call mk6dir2filelist,mark6-11,34,BHC%0174,ehtc2021_GLT_set1_b1.34.filelist)

gl_b4: # BHC%0164/165/166/167 recorder=?? ; Bonn mark6-11
	$(call mk6dir2filelist,mark6-11,12,BHC%0164,ehtc2021_GLT_set1_b4.12.filelist)
	$(call mk6dir2filelist,mark6-11,34,BHC%0166,ehtc2021_GLT_set1_b4.34.filelist)

## SMT

mg_b1: # ALMA%045/46/47/48 ; Bonn mark6-09
	$(call mk6dir2filelist,mark6-09,12,ALMA%045,ehtc2021_SMT_set1_b1.12.filelist)
	$(call mk6dir2filelist,mark6-09,34,ALMA%047,ehtc2021_SMT_set1_b1.34.filelist)

## Kitt Peak

kt_b1: # SAO%0032/33/34/35 ; Bonn mark6-10
	$(call mk6dir2filelist,mark6-10,12,SAO%0032,ehtc2021_KT_set1_b1.12.filelist)
	$(call mk6dir2filelist,mark6-10,34,SAO%0034,ehtc2021_KT_set1_b1.34.filelist)

kt_b4: # SHAO%044/45/46/48 ; Bonn mark6-11
	$(call mk6dir2filelist,mark6-11,12,SHAO%044,ehtc2021_KT_set1_b4.12.filelist)
	$(call mk6dir2filelist,mark6-11,34,SHAO%046,ehtc2021_KT_set1_b4.34.filelist)

## ALMA

aa_b1: # ALMA%009/10/11/12 ; Bonn mark6-02
	$(call mk6dir2filelist,mark6-02,12,ALMA%009,ehtc2021_ALMA_set1_b1.12.filelist)
	$(call mk6dir2filelist,mark6-02,34,ALMA%011,ehtc2021_ALMA_set1_b1.34.filelist)

## SMA APHIDS

sw_b1: # GLT%0017/17/19/20 ; Bonn mark6-??
	$(call mk6dir2filelist,mark6-06,12,GLT%0017,ehtc2021_SMA_set1_b1.12.filelist)
	$(call mk6dir2filelist,mark6-06,34,GLT%0019,ehtc2021_SMA_set1_b1.34.filelist)

sw_b4: # PERI%039/40/41/42 ; Bonn mark6-??
	$(call mk6dir2filelist,mark6-06,12,PERI%039,ehtc2021_SMA_set1_b4.12.filelist)
	$(call mk6dir2filelist,mark6-06,34,PERI%041,ehtc2021_SMA_set1_b4.34.filelist)

## SPT

sz_b1: # ALMA%041/42/43/44 ; Bonn mark6-05
	$(call mk6dir2filelist,mark6-05,12,ALMA%041,ehtc2021_SPT_set1_b1.12.filelist)
	$(call mk6dir2filelist,mark6-05,34,ALMA%042,ehtc2021_SPT_set1_b1.34.filelist)

sz_b4: # ALMA%033/34/35/36 ; Bonn mark6-05
	$(call mk6dir2filelist,mark6-05,12,ALMA%033,ehtc2021_SPT_set1_b4.12.filelist)
	$(call mk6dir2filelist,mark6-05,34,ALMA%035,ehtc2021_SPT_set1_b4.34.filelist)

## APEX

ax_b1: # MPI%8042/43/44/45 set 1 ; BHC%0027/BHC%0027/BHC%0029/MPIH%029 set 2 a17 e18
	$(call mk6dir2filelist,mark6-04,12,MPI%8042,ehtc2021_APEX_set1_b1.12.filelist)
	$(call mk6dir2filelist,mark6-04,34,MPI%8044,ehtc2021_APEX_set1_b1.34.filelist)
	$(call mk6dir2filelist,mark6-04,12,BHC%0027,ehtc2021_APEX_set2_b1.12.filelist)
	$(call mk6dir2filelist,mark6-04,34,BHC%0029,ehtc2021_APEX_set2_b1.34.filelist)

ax_b4: # MPI%8046/47/49/50 set 1 ; BHC%0030/31/32/MPIH%034 set 2 a17 e18
	$(call mk6dir2filelist,mark6-04,12,MPI%8046,ehtc2021_APEX_set1_b4.12.filelist)
	$(call mk6dir2filelist,mark6-04,34,MPI%8049,ehtc2021_APEX_set1_b4.34.filelist)
	$(call mk6dir2filelist,mark6-04,12,BHC%0030,ehtc2021_APEX_set2_b4.12.filelist)
	$(call mk6dir2filelist,mark6-04,34,BHC%0032,ehtc2021_APEX_set2_b4.34.filelist)

## JCMT

mm_b1:  # BHC%0069/BHC%0067/BHC%0043/BHC%0049
	$(call mk6dir2filelist,mark6-01,12,BHC%0069,ehtc2021_JCMT_set1_b1.12.filelist)
	$(call mk6dir2filelist,mark6-01,34,BHC%0043,ehtc2021_JCMT_set1_b1.34.filelist)

mm_b4:  # BHC%0068/BHC%0088/BHC%0042/BHC%0064
	$(call mk6dir2filelist,mark6-07,12,BHC%0068,ehtc2021_JCMT_set1_b4.12.filelist)
	$(call mk6dir2filelist,mark6-07,34,BHC%0042,ehtc2021_JCMT_set1_b4.34.filelist)

## CHECKING

buglist:
	# All scans that have unexpected time stamps
	grep -v " 59" ehtc2021_*.filelist

## 

install_b4:
	cp -a *b4* *rec3* /Exps/e21b09/$(REV)/b4/ ; cp -a *b4* *rec3* /Exps/e21b09/$(REV)/b4_outputbands/
	# cp -a *b4* *rec3* /Exps/e21c11/$(REV)/b4/ ; cp -a *b4* *rec3* /Exps/e21c11/$(REV)/b4_outputbands/
	cp -a *b4* *rec3* /Exps/e21e13/$(REV)/b4/ ; cp -a *b4* *rec3* /Exps/e21e13/$(REV)/b4_outputbands/
	cp -a *b4* *rec3* /Exps/e21a14/$(REV)/b4/ ; cp -a *b4* *rec3* /Exps/e21a14/$(REV)/b4_outputbands/
	cp -a *b4* *rec3* /Exps/e21d15/$(REV)/b4/ ; cp -a *b4* *rec3* /Exps/e21d15/$(REV)/b4_outputbands/
	cp -a *b4* *rec3* /Exps/e21a16/$(REV)/b4/ ; cp -a *b4* *rec3* /Exps/e21a16/$(REV)/b4_outputbands/
	cp -a *b4* *rec3* /Exps/e21a17/$(REV)/b4/ ; cp -a *b4* *rec3* /Exps/e21a17/$(REV)/b4_outputbands/
	cp -a *b4* *rec3* /Exps/e21e18/$(REV)/b4/ ; cp -a *b4* *rec3* /Exps/e21e18/$(REV)/b4_outputbands/


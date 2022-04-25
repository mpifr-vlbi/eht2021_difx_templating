# DiFX Setup Generator for EHT 2021

Prepares DiFX VEX and v2d files for the EHT 230 GHz VLBI obervation of April 2021. Settings are based on the succesful setups that were already derived for the DR2021 fringe test observations, auto-generator scripts (noema-vex-defs.py, alma-vex-defs.py), notes on the EHT wiki, observing logs, email exchanges.

Usage:

```
git clone https://github.com/mpifr-vlbi/eht2021_difx_templating.git
cd eht2021_difx_templating
git checkout master   # later: checkout of a specific tag rather than 'master'
make prerequisites
make all
make install
```

Note:
- ALMA Cycle 7+ used CALC 11, need DIFX_CALC_PROGRAM=difxcalc

TODO:
- [ ] Generate file lists for all bands and stations
- [ ] New branch for developments, 'main' only for releases
- [ ] 'Make' three sets of setups: outputband v2d configs, normal zoom band v2d configs with ALMA sans NOEMA, normal zoom band v2d config swith NOEMA sans ALMA, all three share same VEX

Detailed notes are on the EHT wiki (https://eht-wiki.haystack.mit.edu/Event_Horizon_Telescope_Home/Observing/2021_April/Correlation and other pages).
Metadata and packaging is done elsewhere under the EHT L1 process (https://github.com/mpifr-vlbi/l1calib).

#!/usr/bin/perl
#@xyzfit=(4523928.3,-468030.1,4460383.7,"N13");
#@xyzfit=(4524000.430,468042.140,4460309.760,"W00"); #VLBI pos w00
@xyzfit=(4524000.430,468042.140,4460309.760,"W00"); #VLBI pos w00
@stn=(
     17.4321,   -54.6713,    -17.6563,   "W00",
     11.8205,   -55.0239,    -11.9726,   "N01",
      6.2035,   -55.3708,     -6.2833,   "N02",
      0.5849,   -55.7232,     -0.5926,   "N03",
    -10.6409,   -56.4214,     10.7789,   "N05",
    -21.8689,   -57.1214,     22.1518,   "N07",
    -33.1008,   -57.8196,     33.5285,   "N09",
    -44.3355,   -58.5136,     44.9087,   "N11",
    -55.5592,   -59.2193,     56.2766,   "N13",
    -66.7863,   -59.9207,     67.6481,   "N15",
    -78.0155,   -60.6202,     79.0233,   "N17",
    -94.8616,   -61.6677,     96.0841,   "N20",
   -145.4009,   -64.8169,    147.2738,   "N29",
   -207.1579,   -68.6682,    209.8223,   "N40",
   -240.8464,   -70.7678,    243.9441,   "N49",
   -285.7644,   -73.5672,    289.4398,   "N54",
     16.2163,   -62.4889,    -16.4266,   "W01",
     11.3515,   -93.7227,    -11.5024,   "W05",
      7.7069,  -117.1487,     -7.8139,   "W08",
      6.4919,  -124.9643,     -6.5813,   "W09",
      5.2780,  -132.7724,     -5.3512,   "W10",
      2.8484,  -148.3853,     -2.8915,   "W12",
     -6.8766,  -210.8708,      6.9551,   "W20",
    -10.5202,  -234.3135,     10.6451,   "W23",
    -15.3883,  -265.5590,     15.5711,   "W27",
     21.0757,   -31.2318,    -21.3473,   "E03",
     22.2913,   -23.4309,    -22.5785,   "E04",
     29.5828,    23.4370,    -29.9600,   "E10",
     32.0177,    39.0608,    -32.4249,   "E12",
     36.8755,    70.3000,    -37.3469,   "E16",
     39.3054,    85.9189,    -39.8081,   "E18",
     45.3817,   124.9799,    -45.9624,   "E23",
     46.5964,   132.7882,    -47.1932,   "E24",
     61.1899,   226.5125,    -61.9599,   "E36",
     75.7762,   320.2389,    -76.7281,   "E48"
);
#make stn positions relative to w00
for ($i=0; $i < $#stn+1; $i=$i+4){
   $stnfit[$i  ]=$stn[$i  ]-$stn[0];  #x
   $stnfit[$i+1]=$stn[$i+1]-$stn[1];  #y
   $stnfit[$i+2]=$stn[$i+2]-$stn[2];  #z
   $stnfit[$i+3]=$stn[$i+3];          #name
#  print "XX $stnfit[$i+3] $stnfit[$i] $stnfit[$i+1] $stnfit[$i+2] \n";
}
#longitude of array centre is ref for xyz
$rl= -5.907917*3.1415926535/180.0 ;
$cl=cos($rl); $sl=sin($rl);
print "CS= $cl $sl \n";
for ($i=0;$i<$#stn+1; $i=$i+4){
  $nstn=$i/4; 
  $xs=$stnfit[$i]  ;$ys=$stnfit[$i+1]; $zs=$stnfit[$i+2];
  $xc[$nstn]=$xs*$cl+$ys*$sl; 
  $yc[$nstn]=-$ys*$cl+$xs*$sl;
  $zc[$nstn]=$zs; 
  $names=$stn[$i+3];
}
# make x,y,z for each and dlat,dlong from centre, height asl for interest
for ($i=0;$i<$nstn+1; $i++){
  $x=$xyzfit[0]+$xc[$i]; $y=$xyzfit[1]-$yc[$i]; $z=$xyzfit[2]+$zc[$i];
  $long=atan2($y,$x);
  $radius=sqrt($x*$x+$y*$y+$z*$z);
  $singclat=$z/$radius; $cosgclat=sqrt(1.0-$singclat*$singclat);
  $gclat=atan2($singclat,$cosgclat);
  $lat=-3.35899e-3*sin(2.0*$gclat)+5.6398e-6*sin(4.0*$gclat)-0.01261e-6*sin(6.0*$gclat);
  $lat=$gclat-$lat; 
  $rho=6378160.0*(0.998327073+0.001676438*cos(2.0*$lat)-3.519e-6*cos(4.0*$lat)+8.0e-9*cos(6.0*$lat));
  $height=$radius-$rho;
  $long=$long*180.0/3.141592654; $lat=$lat*180.0/3.141592654; $gclat=$gclat*180.0/3.141592654; 
  $dlong=$long-5.9066686; $dlat=$lat-44.633757;
  #fiddle factors necessary to get us to VLBI standard positions....
  $stnam=$stn[$i*4+3];
  if($stnam ne "W00"){$x=$x-2.2; $y=$y+1.7; $z=$z+4;}
  $pxyz=sprintf("%8.3f %8.3f %8.3f ",$x,$y,$z); 
  $lalo=sprintf("%9.6f %9.6f %10.6f %10.6f",$dlong,$dlat,$long,$lat);
  print "$stnam $pxyz  $lalo  $height\n";
}
print " check: that should give known pos as follows:\n";
print " W00: 4524000.430 468042.140 4460309.760 \n";
print " W08: 4523994.700 467980.700 4460319.0   \n"; 
print " N07?: 4523957.200 468040.000 4460330.0   \n"; # (or is it n05, n09??)
print " N07?: 4523961.595 468035.654 4460349.575 \n";
print " N13: 4523926.296 468033.201 4460383.7   \n";
print " N17: 4523903.7   468028.0   4460402.0   \n";
print " W05: 4523996.400 468003.700 4460308.000 \n";
print " N02: 4523987.100 468042.500 4460319.000 \n";
print " E04: 4523999.790 468075.310 4460303.000 \n"; #excellent fit XY, Z NBG
#NB google earth gives axis crossing (W00) as 443801.28N, 055424.27E
#That is 44.63368889N, 05.90674167E
#VLBI pos we get for W00 is 44.633758/ 5.906669 or 443801.52/055424.00 which is just at to left
#edge of dish.


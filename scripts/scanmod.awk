
BEGIN{
    fsch=0
}
{
    if( fsch=0 ){
    if( $1=="$SCHED;" ){
       fsch=1;
       print $0;
       next;}
    else{
        print $0;
        next;
    }
    }
    if( substr($1,1,1)=="*" ){
    print $0;
    next;
    }
    if( $1=="scan" ){
    getline;
    linie = 0;
        while( substr($1,1,1)== "*" ){
        linie++;
        Koment[linie] = $0;
        getline;
    }
    if( substr($1,1,5)!="start"){
        print "ERROR scan not followed by start line! line: " NR ;
        exit(1);}
    else{
        ind = index($0,"y");
        doy=substr($0,ind+1,3);
        hh=substr($0,ind+5,2);
        mm=substr($0,ind+8,2);
#        ss=substr($0,ind+11,2);
#        print "scan " doy"-" hh mm ss";" ;
        print "scan " doy"-" hh mm";" ;
        i = 0;
        while( i < linie){
        i++;
        print Koment[i];
        }
    }
    }
    print $0;
}

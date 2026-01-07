#!/bin/sh

date
echo sort
for CROSS in MxS SxM ; do
    for REP in BR1 BR2 BR3 BR4 ; do
	echo ${CROSS} ${REP} pat
	sort ${CROSS}_${REP}.paternal.txt > ${CROSS}_${REP}.pat.IDs.txt
	echo ${CROSS} ${REP} mat
	sort ${CROSS}_${REP}.maternal.txt > ${CROSS}_${REP}.mat.IDs.txt
	date
    done
done

echo gzip
gzip -v *at.IDs.txt

echo DONE
	

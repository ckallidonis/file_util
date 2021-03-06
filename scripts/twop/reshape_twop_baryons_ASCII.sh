#!/bin/bash

if [ $# -ne 5 ]
then
    echo "Usage: $0 <ini_dir> <out_dir> <src_list> <mom_list> <conf>"
    exit
fi

INI_DIR=$1
OUT_DIR=$2
SRC_LIST=$3
MOM_LIST=$4
CONF=$5

while read x y z t
do
    BAR_FILE=${INI_DIR}/twop.${CONF}.baryons.SS.${x}.${y}.${z}.${t}.dat
    BAROUT_FILE=${OUT_DIR}/twop_rshp.${CONF}.baryons.SS.${x}.${y}.${z}.${t}.dat
    
    rm -f ${BAROUT_FILE}

    for i in 0 1 2 3 4 5 6 7 8 9
    do
	while read mx my mz
	do
	    grep -- "^${i}" ${BAR_FILE} | grep -- "${mx} ${my} ${mz}" >> ${BAROUT_FILE}
	done < ${MOM_LIST}
    done

    echo sx${x}sy${y}sz${z}st${t}

done < ${SRC_LIST}

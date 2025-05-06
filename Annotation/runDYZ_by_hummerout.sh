#!/bin/bash

cat sample_list | while read id; do
    mkdir -p "${id}"
    cd "${id}" || { echo "Cannot enter directory ${id}. Exiting."; exit 1; }
    cat ${id}.DYZ1.nhmmer.tab \
        ${id}.DYZ2.nhmmer.tab | \
        sed 's/EMBOSS_001/DYZ2/' | awk '{if($13==0) print}'| \
        awk '{
            if ($12 == "-") {
                temp = $7 - 1;
                $7 = $8 - 1;
                $8 = temp;
            }
            print $1, $7, $8, $3, ".", $12;
        }' OFS='\t' | grep -v '^#' | sort -n -k2 > "${id}.DYZ.bed"



    python rename.py "${id}.DYZ.bed" "${id}.DYZ.rename.bed"

    
    grep 'DYZ1' "${id}.DYZ.rename.bed" > "${id}.DYZ1.bed"
    grep 'DYZ2' "${id}.DYZ.rename.bed" > "${id}.DYZ2.bed"


    bedtools getfasta -s -nameOnly -bed "${id}.DYZ1.bed" -fi ${id}.chrY.fa -fo "${id}.DYZ1.fas"
    bedtools getfasta -s -nameOnly -bed "${id}.DYZ2.bed" -fi ${id}.chrY.fa -fo "${id}.DYZ2.fas"


    cd ..

done

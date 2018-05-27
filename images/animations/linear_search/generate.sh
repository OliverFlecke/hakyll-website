#!/bin/bash

for i in {4..21..2}
    do
        value=`cat $1`
        let "column= ($i - 1) / 2"
        value="${value/columnindex/$column}"
        filename="${1%.*}"`printf "%02d" $i`.tex
        # echo "$value"
        echo "$value" > $filename
    done
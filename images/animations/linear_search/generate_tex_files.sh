#!/bin/bash

for i in {3..21..2}
    do
        value=`cat $1`
        let "column= ($i - 1) / 2"
        value="${value/columnindex/$column}"
        filename="${1%.*}"`printf "%02d" $i`.tex
        echo "$value" > $filename
    done
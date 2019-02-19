#!/bin/bash

#
# This is a wrapper-script for do_check_ca.sh and provides a means
# to check multiple domains in a batch.
# All domains should be put in the file that is passed as an argument
# to this script and separated by newlines
#

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -z $1 ]
then
        echo "usage: check_cas.sh [input file]"
else
        input_file="$1"
fi

echo "===== Checking all domains in $1 for ssl certificates at "`date`" ====="

while read LINE; do
        if [ ${LINE:0:1} == "#" ]
        then
                echo "== skipping $LINE"
        else
                $THIS_DIR/do_check_ca.sh $LINE
        fi
done < $input_file

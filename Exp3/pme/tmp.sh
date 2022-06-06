#! /bin/bash

HOME_DIR=$PWD
DATA_DIR="/home/ekuec/Projects/HSG/diso_calc"
input=$1
LPS_DIR="/home/ekuec/Projects/HSG/sets/new_mangsets/ref"

#declare -a arr=("test")
#for dir in ${arr[@]}; do
    cd $DATA_DIR
      while IFS= read -r var
      do
        if [ -d *$var ]; then 
          cd *$var
          for f in *.fasta; do
            name=${f%.fasta}
            hsg_len.pl $var $name $LPS_DIR >> $HOME_DIR/${input%.txt}.len
          done
          cd ../
        else
         echo "MISSING $var!"
       fi
      done < "$HOME_DIR/$input"
# THIS IS BAD PRACTICE
cd $HOME_DIR

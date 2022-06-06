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
            hsg_analysis.pl $var $name $LPS_DIR >> $HOME_DIR/${input%.txt}.diso
            aa_analysis.pl $var $name $LPS_DIR  >> $HOME_DIR/${input%.txt}.zaa
            quick_charge.pl $var $name $LPS_DIR >> $HOME_DIR/${input%.txt}.seq
            hsg_ordered.pl $var $name $LPS_DIR  >> $HOME_DIR/${input%.txt}.ord
            hsg_segments.pl $var $name $LPS_DIR >> $HOME_DIR/${input%.txt}.egg
            grep -w "$var" $LPS_DIR/abundance.list >> $HOME_DIR/${input%.txt}.abd
            grep -w "$var" $LPS_DIR/pme.ss8.dat    >> $HOME_DIR/${input%.txt}.ss8
            grep -w "$var" $LPS_DIR/pme_hl.tsv     >> $HOME_DIR/${input%.txt}.hl
            grep -w "$var" $LPS_DIR/pme.acc.dat    >> $HOME_DIR/${input%.txt}.acc
            grep -w "$var" $LPS_DIR/yeast.full.aa  >> $HOME_DIR/${input%.txt}.faa
            grep -w "$var" $LPS_DIR/yeast.idr.aa   >> $HOME_DIR/${input%.txt}.iaa
          done
          cd ../
        else
         echo "MISSING $var!"
       fi
      done < "$HOME_DIR/$input"
# THIS IS BAD PRACTICE
cd $HOME_DIR

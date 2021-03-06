#!/bin/bash


#Commands below will find, copy, and write to nf$1.d12 structural information of the required structure frmo gatheredPOSCARD_order file
{ echo -e "###"
  echo "CRYSTAL"
  echo "0 0 0"
  echo "1"
  grep -A 40 -w EA$1 gatheredPOSCARS_order |  grep -B 30 -w EA$2 | grep EA$1 | awk '{print $2, $3, $4, $5, $6, $7}'
  grep -A 40 -w EA$1 gatheredPOSCARS_order |  grep -B 30 -w EA$2 | grep -A 130 Direct | head -n -1 | awk '{print $1, $2, $3}' | tail  -n +2 | cat -n | awk '{print $1}' | tail -n 1
  grep -A 40 -w EA$1 gatheredPOSCARS_order |  grep -B 30 -w EA$2 | grep -A 130 Direct | head -n -1 | awk '{print $1, $2, $3}'  | tail  -n +2
  echo -e "FINDSYM"
  echo -e "END"
} > nf$1.d12

#Commands below will create CRYSTAL14 input file by copying the basic structure from one of the CRYSTAL14 output files. Next, it will add the coordinates to the file
head -300 ../../CalcFold1/CRYSTAL.o | sed -n '/ AT.IRR./,/NUMBER/p' | awk '{print $3}' | head -n -1 | tail -n +2 > tmp1.d12
tail -n +7 nf$i.d12 > tmp2.d12
paste tmp1.d12 tmp2.d12 | head -n -2 > tmp3.d12
head -n +6 nf$i.d12 > tmp4.d12
tail -n -2 nf$i.d12 > tmp5.d12
cat tmp4.d12 tmp3.d12 > tmp6.d12
cat tmp6.d12 tmp5.d12 > str$i.d12

rm tmp*
rm nf*

#Command below will carry out search of the space group of the structure with tolerance 0.1
runcrys	-tol 0.1 str$i.d12


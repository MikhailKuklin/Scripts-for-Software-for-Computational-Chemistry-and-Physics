#!/bin/bash

squeue -u mkuklin | awk '{print $1}' |  cut -d "_" -f1 | uniq | tail -n +2 > tmpl

echo ""
echo -e "\033[37mSTATUS\033[0m" "     |" "\033[37mRUN TIME\033[0m" "|" "\033[37mID\033[0m" "     |" "\033$
echo "---------------------------------------------------------------------------------------------------$

for i in $(cat tmpl)
do
time=$(scontrol show job $i | grep "RunTime=" | head -n 1 | awk '{print $1}' | cut -d "=" -f2)
runtime=$(scontrol show job $i | grep "RunTime=" | awk '{print $1}' | cut -c 9-)
if [ "$time" == "00:00:00" ]
then
echo -e "\033[31mNot started\033[0m" "| "00:00:00" |" $i "|" $(scontrol show job $i | grep WorkDir | cut $
else
echo -e "\033[32mRunning\033[0m" "    |" $runtime" |" $i "|" $(scontrol show job $i | grep WorkDir | cut $
fi
done
echo ""

rm tmpl

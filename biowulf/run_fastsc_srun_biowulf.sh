#!/bin/bash

compiledpath=$1
filename=$2
nbnodes=$3
nbclusters=$4
outputlabelfile=$5

srun --partition=gpu --gres=gpu:k80:1 $compiledpath $filename $nbnodes $nbclusters $outputlabelfile


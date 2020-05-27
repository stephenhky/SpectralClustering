#!/bin/bash

#SBATCH --output=$HOME/.fastsc/fastsc.output%A.tmp
#SBATCH --error=$HOME/.fastsc/fastsc.error%A.tmp
#SBATCH --partition=gpu
#SBATCH --gres=gpu:k80:1

compiledpath=$1
filename=$2
nbnodes=$3
nbclusters=$4
outputlabelfile=$5

$compiledpath $filename $nbnodes $nbclusters $outputlabelfile

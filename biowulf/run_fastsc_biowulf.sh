#!/bin/bash

#SBATCH
#SBATCH --output=/tmp/fastsc.output%A.tmp
#SBATCH --error=/tmp/fastsc.error%A.tmp
#SBATCH --gres=gpu:k80:1

compiledpath=$1
filename=$2
nbnodes=$3
nbclusters=$4
outputlabelfile=$5

$compiledpath $filename $nbnodes $nbclusters $outputlabelfile

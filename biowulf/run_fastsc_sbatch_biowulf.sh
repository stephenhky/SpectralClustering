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

srun $compiledpath $filename $nbnodes $nbclusters $outputlabelfile



# command line
# srun --partition=gpu --gres=gpu:k80:1 /home/hok/installing/fastsc/spectral_clustering /data/hok/testdata/fastsc/two_circles_1000_output_k2.txt 1000 2 /data/hok/testdata/fastsc/two_circles_1000_output_k2_scoutput.txt
# Setup of FastSC on NIH Biowulf Cluster

This directory contains scripts that enable us to run 
[FastSC](https://github.com/yuj-umd/fastsc) on NIH
[Biowulf](https://hpc.nih.gov/) clusters.

## Installation

To install it on Biowulf, login to Biowulf, and run:

```buildoutcfg
wget https://github.com/stephenhky/SpectralClustering/blob/master/biowulf/intall_fastsc_biowulf.sh
./install_fastsc_biowulf
```

Note that the script made use of the forked repositories
of [fastsc](https://github.com/stephenhky/fastsc) 
and [arpackng](https://github.com/stephenhky/arpackpp).

## Execution

The compiled code is in the directory `$HOME/installing/fastsc`.
To run it, 

```buildoutcfg
path/to/run_fastsc_srun_biowulf.sh <compiled code path> <input file> <number of nodes> <number of clusters> <output file>
```

Or do sbatch (not successful, pending)

```buildoutcfg
path/to/run_fastsc_sbatch_biowulf.sh <compiled code path> <input file> <number of nodes> <number of clusters> <output file>
```

Or start an interactive batch session:

```buildoutcfg
sinteractive --gres=gpu:k80:1
<compiled code path> <input file> <number of nodes> <number of clusters> <output file>
```


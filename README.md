# smatlab

_Author_: **Jeremy GUILLON**  
_Contact_: [jeremy.guillon@inria.fr](mailto:jeremy.guillon@inria.fr)  
_Date_: February 26th, 2016  
_Version_: 1.0


## Introduction

This project aims at providing a _simple_ and _efficient_ way to execute MATLAB&reg; scripts on a cluster managed by [Slurm](http://slurm.schedmd.com/).


## Installation

### SSH to cluster
```bash
ssh [USERNAME]@[CLUSTER_HOSTNAME]
```

### Download `smatlab` tool
Download this project in the desired `DIRECTORY`, if none is specified, the following command will download it in `./smatlab`.
```bash
git clone https://github.com/jguillon/smatlab.git [DIRECTORY]
```

### Define `PATH` environment variable
Add `smatlab` directory to the path. For that, edit your `~/.bashrc` file using the following command:
```bash
vim ~/.bashrc
```
And add the following line:
```bash
export PATH=path/to/smatlab/directory:${PATH}
```


## Getting Started

### Basic usage

Basic usage of `smatlab` consists in submitting one single job to Slurm. It can be done like this: 
```bash
smatlab path/to/your/matlab/script.m
```
where `script.m` can be any MATLAB&reg; script.

> Be aware that MATLAB&reg; will add the path to your script to its path. Functions or scripts that are outside your script path have to be managed properly (i.e. you have to make them accessible by your script).

Run `smatlab examples/simple_script.m` for example.

### MATLAB&reg; parralel computing

When your script contains a `parfor` statement or any command of the [Parallel Computing Toolbox](http://www.mathworks.com/products/parallel-computing/index.html?s_tid=gn_loc_drop), you can run it with a specification on the number of CPUs you need. For example, the following command will submit one job (with one task) to Slurm, but MATLAB&reg; will be able to execute code on 12 different CPUs (maximum) at the same time.
```bash
smatlab --cpus-per-task=12 path/to/your/matlab/script.m
```

Run `smatlab --cpus-per-task=12 examples/parralel_script.m` for example.

### Slurm parralel computing

```bash
smatlab --job-array=1:200 path/to/your/matlab/script.m
```

Run `smatlab --job-array=1:200 examples/ultimate_script.m` for example or `smatlab --job-array=1:200 --cpus-per-task=12 examples/ultimate_script.m` for even more magic.

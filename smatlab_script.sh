#!/bin/bash

export LANG=fr_FR.UTF-8

matlab_script="try, disp(pwd); disp('$1'); addpath(fileparts('$1')); $2; catch err, display(err.message); disp(getReport(err,'extended')); end; quit force;"

matlab -nodesktop -nosplash -nodisplay -nosoftwareopengl -r "${matlab_script}"

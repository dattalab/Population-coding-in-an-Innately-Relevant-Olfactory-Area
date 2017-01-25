# Population-coding-in-an-Innately-Relevant-Olfactory-Area
Iurilli and Datta, 2017 - Neuron     

This repository contains custom Arduino code for olfactometer control, Matlab scripts and wrapper code for classification analysis and concentration analysis as performed in Iurilli and Datta, 2017. Additional scripts and functions to easily explore the data (e.g. calculate smoothed PSTH, retrieve baseline/response firing rates, compute auROC of olfactory responses, measure lifetime sparseness of a neuron, etc.) are also provided here.
Note that the Matlab scripts for classification analysis employ the LIBSVM library that can be downloaded [here](http://www.csie.ntu.edu.tw/~cjlin/libsvm/).

This repository also contains the data used in the paper as .mat files. The prefix of each file indicates the area (aPCx = anterior Piriform Cortex; plCoA = postero-lateral Cortical Amygdala). All files are hierarchically organized as: source experiment -> shank probe -> single unit -> stimulus. 

Each file contains info about the mean waveform of each unit over the 8 channels of a probe, spike sorting quality indices for that unit and several descriptive measurements for each cell-odor pair (baselines, responses, reliabilities etc.). These files can be used with the code provided in this repository.

Please contact srdatta@hms.harvard.edu for further information.

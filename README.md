# Population-coding-in-an-Innately-Relevant-Olfactory-Area
Iurilli and Datta, 2017 - Neuron     

This repository contains custom Arduino code for olfactometer control, Matlab scripts and wrapper code for classification analysis and concentration analysis as performed in Iurilli and Datta, 2017. Additional scripts and functions to easily explore the data (e.g. calculate smoothed PSTH, retrieve baseline/response firing rates, compute auROC of olfactory responses, measure lifetime sparseness of a neuron, etc.) are also provided here.
Note that the Matlab scripts for classification analysis employ the LIBSVM library that can be downloaded [here](http://www.csie.ntu.edu.tw/~cjlin/libsvm/).

This repository also includes the data used in the paper as .mat files. The prefix of each file indicates the area (aPCx = anterior Piriform Cortex; plCoA = postero-lateral Cortical Amygdala). The suffix indicates the type of experiment (15 = 15 monomolecular odorants; AA = aversive/appetitive odors; CS = concentration series of three odors; NM = natural mixtures of odorants). All files are hierarchically organized as: source experiment -> shank probe (1 = most anterior / 4 = most posterior) -> single unit -> odor presented -> matrix of spikes. 

Spike data are formatted as sparse matrices of ones (spike) and zeros (no spike) with dimensions trials X time (10 trials X 10000 ms; one column = 1 ms). The response window starts at 4000 ms (after re-alignement of spikes to the first inhalation post odor valve opening). Odors were delivered for 2000 ms.

Each file also includes the mean waveform of each unit over the 8 channels of a probe and spike sorting quality indices for that unit. These files can be used with the code provided in this repository.

Please contact Giuliano_Iurilli@hms.harvard.edu for further information.

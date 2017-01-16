# Population-coding-in-an-Innately-Relevant-Olfactory-Area
Iurilli and Datta, 2017 - Neuron     
This repository contains custom Arduino code for olfactometer control, Matlab scripts for behavioral experiments and wrapper code for classification analysis and concentration analysis as performed in Iurilli and Datta, 2017.
Note that the Matlab scripts for classification analysis employ the LIBSVM library that can be downloaded here (http://www.csie.ntu.edu.tw/~cjlin/libsvm/).
This repository also contains the data used in the paper as .mat files. The prefix of each file indicates the area (aPCx = anterior Piriform Cortex; plCoA = postero-lateral Cortical Amygdala). All files are hierarchically organized as: source experiment -> shank probe -> single unit -> stimulus. 
Files ending in 1 contain the spike times for a given cell-odor pair formatted as a 0/1 spike matrix whose rows represent trials and whose columns represent time points in milliseconds (10000 columns = 10000 ms). Ones indicate the presence of a spike. For each trial/row, the response window starts after 3000 ms.
Files ending in 2 contain info about the mean waveform of each unit over the 8 channels of a probe, spike sorting quality indices for that unit and several measurements for each cell-odor pair (baselines, responses, reliabilities etc.). This files can be used with the code provided in this repository.
Files ending in 3 are like files ending in 1, but spikes are referenced to the phase of each respiration cycle (in deg).
Please contact srdatta@hms.harvard.edu for further information.

function plotPSTH(espe, idxExp, idxShank, idxUnit, idxOdor, binSize, moveBy)

spikesArray = single(full(espe(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).spikeMatrix));
[slidingPSTHmn, slidingPSTHsd, slidingPSTHCV, slidingPSTH, t_vector] = slidePSTH(spikesArray, binSize, moveBy);

figure
plot(t_vector, slidingPSTHmn)

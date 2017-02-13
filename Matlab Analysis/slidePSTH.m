function [slidingPSTHmn, slidingPSTHsd, slidingPSTHCV, slidingPSTH, t_vector] = slidePSTH(spikesArray, binSize, moveBy)

if nargin < 3
    moveBy = 5;
end

if nargin < 2
    binSize = 10;
    moveBy = 5;
end

nTrials = size(spikesArray, 1);
nTimepoints = size(spikesArray, 2);

slidingPSTH = zeros(nTrials, nTimepoints);

for idxTrial = 1:nTrials
    spikeVector = spikesArray(idxTrial,:);
    k = ones(1, binSize);
    slidingPSTH(idxTrial,:) = conv(spikeVector, k, 'same');
end

slidingPSTH = slidingPSTH(:,1:moveBy:end);
slidingPSTHmn = nanmean(slidingPSTH,1);
slidingPSTHsd = nanstd(slidingPSTH,1);
slidingPSTHCV = slidingPSTHsd ./ slidingPSTHmn;
t_vector = linspace(0,size(spikesArray,2), length(slidingPSTHmn));

end






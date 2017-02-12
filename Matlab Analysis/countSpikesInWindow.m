function spikeCount = countSpikesInWindow(spikeMatrix, window)

spikeCount = sum(spikeMatrix(:, floor(window(1)*1000) : floor(window(2)*1000)), 2)';

end
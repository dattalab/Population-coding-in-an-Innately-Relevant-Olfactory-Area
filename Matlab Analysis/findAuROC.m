function [auR, significance] = findAuROC(bslVect, rspVect, checkSignificance)

%rspVect, bslVect: number of spikes in the bin for each trial

bslVect = double(bslVect(:));
rspVect = double(rspVect(:));
reps = 1000;
labels = [zeros(1,length(bslVect)) ones(1,length(rspVect))]';
scores = [bslVect; rspVect];
auR = fastAUC(labels, scores, 1);
my_auR_bs = nan*ones(1,reps);
if checkSignificance == 1
    for j = 1:reps
        permLabels = labels(randperm(length(scores)));
        my_auR_bs(j) = fastAUC(permLabels, scores, 1);
    end
    percentiles = prctile(my_auR_bs, [2.5 97.5]);
    if auR > 0.5
        if auR > percentiles(2)
            significance = 1;
        else
            significance = 0;
        end
    else
        if auR < percentiles(1)
            significance = -1;
        else
            significance = 0;
        end
    end
else
    significance = 1;
end

end
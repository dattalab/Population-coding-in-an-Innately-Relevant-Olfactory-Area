function esp = collectData(espe, odors, windowBaseline, windowResponse)




esp = [];

for idxExp = 1:length(espe)
    for idxShank = 1:4
        if ~isempty(espe(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(espe(idxExp).shank(idxShank).SUA.cell)
                for idxOdor = 1:numel(odors)
                    spikeMatrix = logical(full(espe(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).spikeMatrix));
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good = espe(idxExp).shank(idxShank).SUA.cell(idxUnit).good;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio = espe(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBaseline = countSpikesInWindow(spikeMatrix, windowBaseline);
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse = countSpikesInWindow(spikeMatrix, windowResponse);
                    [auroc, significant] = findAuROC(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBaseline,...
                        esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse, 1);
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse = significant;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DeltaAnalogicResponse = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse -...
                        esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBaseline;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).auROC = auroc;
                end
            end
        else
            esp(idxExp).shank(idxShank).SUA = [];
        end
    end
end

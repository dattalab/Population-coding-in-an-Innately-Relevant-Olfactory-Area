function [tuningCurves, tuningCurvesSig] = findTuningCurves(esp, odors, lratio, onlyexc)

[totalSUA, totalResponsiveSUA, totalResponsiveNeuronPerOdor] = findNumberOfSua(esp, odors, lratio, onlyexc);

%%
tuningCurves = 0.5 * ones(totalSUA, length(odors));
tuningCurvesSig = 0.5 * ones(totalResponsiveSUA, length(odors));
cells = 0;
idxCell = 0;
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                    cells = cells + 1;
                    idxO = 0;
                    app = [];
                    for idxOdor = odors
                        idxO = idxO + 1;
                        tuningCurves(cells, idxO) = mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse) -...
                            mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBaseline);
                        if onlyexc == 1
                            app(idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse == 1;
                        else
                            app(idxO) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse) == 1;
                        end
                    end
                    if sum(app) > 0
                        idxCell = idxCell + 1;
                        tuningCurvesSig(idxCell,:) = tuningCurves(cells, :);
                    end
                end
            end
        end
    end
end
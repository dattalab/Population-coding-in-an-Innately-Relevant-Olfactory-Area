function dataAll = createResponseMatrix(esp, stimuli, option)

if ~isfield(option, 'baseline')
    option.baseline = 0;
end
if ~isfield(option, 'abs')
    option.abs = 1;
end
if ~isfield(option, 'L_ratio')
    lratio = 1;
end


n_stimuli = length(stimuli);


if option.baseline == 0
    dataAll = [];
    idxCell = 0;
    for idxExp = 1:length(esp)
        for idxShank = 1:4
            if ~isempty(esp(idxExp).shank(idxShank).SUA)
                for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                    if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                        resp = zeros(1,n_stimuli);
                        idxS = 0;
                        for idxStimulus = stimuli
                            if option.abs == 1
                                idxS = idxS + 1;
                                resp(idxS) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxStimulus).DigitalResponse) == 1;
                            else
                                idxS = idxS + 1;
                                resp(idxS) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxStimulus).DigitalResponse == 1;
                                deltaResp(idxS) = mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxStimulus).AnalogicResponse) -...
                                    mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxStimulus).AnalogicBaseline);
                            end
                        end
                        if sum(resp) > 0
                            idxCell = idxCell + 1;
                            idxO = 0;
                            
                            %% comment next for-cycle if you want to simulate labeled lines
                            for idxStimulus = stimuli
                                idxO = idxO + 1;
                                dataAll(idxCell,:,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxStimulus).AnalogicResponse -...
                                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxStimulus).AnalogicBaseline;
                            end
                            
                            %% uncomment next for-cycle if you want to simulate labeled lines
                            %                                 [m,k] = max(deltaResp);
                            %                                 for idxStimulus = stimuli
                            %                                     if idxStimulus == k
                            %                                         idxO = idxO + 1;
                            % %                                         dataAll(idxCell,:,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxStimulus).AnalogicResponse -...
                            % %                                             esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxStimulus).AnalogicBaseline;
                            %                                         %instead for 100% reliability
                            %                                         meanResp = mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxStimulus).AnalogicResponse -...
                            %                                             esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxStimulus).AnalogicBaseline);
                            %                                         dataAll(idxCell,:,idxO) = repmat(meanResp,1,10);
                            %                                     else
                            %                                         idxO = idxO + 1;
                            %                                         dataAll(idxCell,:,idxO) = zeros(1,10);
                            %                                     end
                            %                                 end
                        end
                    end
                end
            end
        end
    end
end


if option.baseline == 1
    baselineCellAll = [];
    idxCell = 0;
    for idxExp = 1:length(esp)
        for idxShank = 1:4
            if ~isempty(esp(idxExp).shank(idxShank).SUA)
                for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                    if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                        resp = zeros(1,n_stimuli);
                        idxS = 0;
                        for idxStimulus = stimuli
                            if option.abs == 1
                                idxS = idxS + 1;
                                resp(idxS) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxStimulus).DigitalResponse) == 1;
                            else
                                idxS = idxS + 1;
                                resp(idxS) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxStimulus).DigitalResponse == 1;
                            end
                        end
                        if sum(resp) > 0
                            idxCell = idxCell + 1;
                            idxO = 0;
                            for idxStimulus = stimuli
                                idxO = idxO + 1;
                                dataAll(idxCell,:,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxStimulus).AnalogicBaseline;
                            end
                        end
                    end
                end
            end
        end
    end
end

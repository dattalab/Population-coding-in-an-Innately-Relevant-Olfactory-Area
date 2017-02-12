%% set colors for plotting
coaC = [228,26,28] ./ 255;
pcxC = [55,126,184]./255;

%% collect data
coaCS_1 = load('plCoA_CS.mat');
pcxCS_1 = load('aPCx_CS.mat');

odors = 1:15;
windowBaseline = [2 3];
windowResponse = [4 5];
coaCS2 = collectData(coaCS_1.espe, odors, windowBaseline,  windowResponse);
pcxCS2 = collectData(pcxCS_1.espe, odors, windowBaseline,  windowResponse);
%%
[totalSUACoa, totalResponsiveSUACoa, totalResponsiveNeuronPerOdorCoa, totalSUAExpCoa] = findNumberOfSua(coaCS2.esp, 1:15, 0.5, 0);
[totalSUAPcx, totalResponsiveSUAPcx, totalResponsiveNeuronPerOdorPcx, totalSUAExpPcx] = findNumberOfSua(pcxCS2.esp, 1:15, 0.5, 0);

fractionExcitedNeuronsCoa = totalResponsiveNeuronPerOdorCoa.idxExc.idxO1 ./ repmat(totalSUAExpCoa',1,size(totalResponsiveNeuronPerOdorCoa.idxExc.idxO1,2));
fractionExcitedNeuronsMeanCoa = nanmean(fractionExcitedNeuronsCoa);
fractionExcitedNeuronsSemCoa = nanstd(fractionExcitedNeuronsCoa)./sqrt(size(fractionExcitedNeuronsCoa,1)-1);

fractionInhibitedNeuronsCoa = totalResponsiveNeuronPerOdorCoa.idxInh.idxO1 ./ repmat(totalSUAExpCoa',1,size(totalResponsiveNeuronPerOdorCoa.idxInh.idxO1,2));
fractionInhibitedNeuronsMeanCoa = nanmean(fractionInhibitedNeuronsCoa);
fractionInhibitedNeuronsSemCoa = nanstd(fractionInhibitedNeuronsCoa)./sqrt(size(fractionInhibitedNeuronsCoa,1)-1);

fractionExcitedNeuronsPcx = totalResponsiveNeuronPerOdorPcx.idxExc.idxO1 ./ repmat(totalSUAExpPcx',1,size(totalResponsiveNeuronPerOdorPcx.idxExc.idxO1,2));
fractionExcitedNeuronsMeanPcx = nanmean(fractionExcitedNeuronsPcx);
fractionExcitedNeuronsSemPcx = nanstd(fractionExcitedNeuronsPcx)./sqrt(size(fractionExcitedNeuronsPcx,1)-1);

fractionInhibitedNeuronsPcx = totalResponsiveNeuronPerOdorPcx.idxInh.idxO1 ./ repmat(totalSUAExpPcx',1,size(totalResponsiveNeuronPerOdorPcx.idxInh.idxO1,2));
fractionInhibitedNeuronsMeanPcx = nanmean(fractionInhibitedNeuronsPcx);
fractionInhibitedNeuronsSemPcx = nanstd(fractionInhibitedNeuronsPcx)./sqrt(size(fractionInhibitedNeuronsPcx,1)-1);





%%
fractionExcitedNeuronsSemCoa = reshape(fractionExcitedNeuronsSemCoa', 5,3);
fractionExcitedNeuronsSemCoa = fractionExcitedNeuronsSemCoa';
fractionExcitedNeuronsMeanCoa = reshape(fractionExcitedNeuronsMeanCoa', 5,3);
fractionExcitedNeuronsMeanCoa = fractionExcitedNeuronsMeanCoa';
fractionInhibitedNeuronsSemCoa = reshape(fractionInhibitedNeuronsSemCoa', 5,3);
fractionInhibitedNeuronsSemCoa = fractionInhibitedNeuronsSemCoa';
fractionInhibitedNeuronsMeanCoa = reshape(fractionInhibitedNeuronsMeanCoa', 5,3);
fractionInhibitedNeuronsMeanCoa = fractionInhibitedNeuronsMeanCoa';
fractionExcitedNeuronsSemPcx = reshape(fractionExcitedNeuronsSemPcx', 5,3);
fractionExcitedNeuronsSemPcx = fractionExcitedNeuronsSemPcx';
fractionExcitedNeuronsMeanPcx = reshape(fractionExcitedNeuronsMeanPcx', 5,3);
fractionExcitedNeuronsMeanPcx = fractionExcitedNeuronsMeanPcx';
fractionInhibitedNeuronsSemPcx = reshape(fractionInhibitedNeuronsSemPcx', 5,3);
fractionInhibitedNeuronsSemPcx = fractionInhibitedNeuronsSemPcx';
fractionInhibitedNeuronsMeanPcx = reshape(fractionInhibitedNeuronsMeanPcx', 5,3);
fractionInhibitedNeuronsMeanPcx = fractionInhibitedNeuronsMeanPcx';
%%
for idxOdor = 1:3
    figure
    set(gcf,'Position',[207 388 722 344]);
    set(gcf,'color','white', 'PaperPositionMode', 'auto');
    errorbar(1:5, fliplr(fractionExcitedNeuronsMeanCoa(idxOdor,:)), fliplr(fractionExcitedNeuronsSemCoa(idxOdor,:)), '-o', 'LineWidth', 1, 'MarkerEdgeColor', coaC, 'MarkerFaceColor', coaC, 'MarkerSize', 8, 'color', coaC)
    set(gca, 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14, 'box', 'off')
    ylabel('Fraction Excited Neuron')
    xlabel('odor I.D.')
    ylim([0 0.2])
    figure
    set(gcf,'Position',[207 388 722 344]);
    set(gcf,'color','white', 'PaperPositionMode', 'auto');
    errorbar(1:5, fliplr(fractionExcitedNeuronsMeanPcx(idxOdor,:)), fliplr(fractionExcitedNeuronsSemPcx(idxOdor,:)), '-o', 'LineWidth', 1, 'MarkerEdgeColor', pcxC, 'MarkerFaceColor', pcxC, 'MarkerSize', 8)
    set(gca, 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14, 'box', 'off')
    ylabel('Fraction Excited Neuron')
    xlabel('odor I.D.')
    ylim([0 0.2])
end

%%
odors = 1:15;



[VariantCoa, InvariantCoa, nonmonotonicCoa, nonmonotonicSemCoa, monotonicDCoa, monotonicDSemCoa, monotonicICoa, monotonicISemCoa, cellLogCoa, n_cellsCoa] = findConcInvarianceAndMonotonicity_new(coaCS2.esp);
[VariantPcx, InvariantPcx, nonmonotonicPcx, nonmonotonicSemPcx, monotonicDPcx, monotonicDSemPcx, monotonicIPcx, monotonicISemPcx, cellLogPcx, n_cellsPcx] = findConcInvarianceAndMonotonicity_new(pcxCS2.esp);
%% as in Fig. 6C - right panels (Concentration Variant)
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
for idxOdor = 1:3
    xMean = [nonmonotonicCoa(idxOdor) nonmonotonicPcx(idxOdor); monotonicDCoa(idxOdor) monotonicDPcx(idxOdor); monotonicICoa(idxOdor) monotonicIPcx(idxOdor)];
    xSem = [nonmonotonicSemCoa(idxOdor) nonmonotonicSemPcx(idxOdor); monotonicDSemCoa(idxOdor) monotonicDSemPcx(idxOdor); monotonicISemCoa(idxOdor) monotonicISemPcx(idxOdor)];
    subplot(3,1,idxOdor)
    b = barwitherr(xSem, xMean);
    b(1).EdgeColor = coaC;
    b(1).FaceColor = coaC;
    b(2).EdgeColor = pcxC;
    b(2).FaceColor = pcxC;
    set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
end
%% as in Fig. 6C - left panels
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
for idxOdor = 1:3
    xMean = [VariantCoa(idxOdor) VariantPcx(idxOdor); InvariantCoa(idxOdor) InvariantPcx(idxOdor)];
    semCoa = sqrt(xMean(1,1) * xMean(2,1) / (n_cellsCoa(idxOdor)-1));
    semPcx = sqrt(xMean(1,2) * xMean(2,2) / (n_cellsPcx(idxOdor)-1));
    xSem = [semCoa, semPcx; semCoa, semPcx];
    subplot(3,1,idxOdor)
    b = barwitherr(xSem, xMean);
    b(1).EdgeColor = coaC;
    b(1).FaceColor = coaC;
    b(2).EdgeColor = pcxC;
    b(2).FaceColor = pcxC;
    set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
    ylim([0 1])
end

%% as in Fig. 6D
[concCoa, totalResponsiveSUACoa] = findOdorDiscriminative_new(coaCS2.esp, odors, 1, 1);
[concPcx, totalResponsiveSUAPcx] = findOdorDiscriminative_new(pcxCS2.esp, odors, 1, 1);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
concCoaP = concCoa ./ totalResponsiveSUACoa;
concPcxP = concPcx ./ totalResponsiveSUAPcx;
concCoaP = fliplr(concCoaP);
concPcxP = fliplr(concPcxP);
p_1 = ones(1,5);
p_1Coa = p_1 - concCoaP;
p_1Pcx = p_1 - concPcxP;

for idxConc = 1:5
    semCoa(idxConc) = sqrt(concCoaP(idxConc) * p_1Coa(idxConc) ./  (totalResponsiveSUACoa-1));
    semPcx(idxConc) = sqrt(concPcxP(idxConc) * p_1Pcx(idxConc) ./  (totalResponsiveSUAPcx-1));
end

meanX = [concCoaP', concPcxP'];
semX = [semCoa' semPcx'];

b = barwitherr(semX, meanX);
b(1).EdgeColor = coaC;
b(1).FaceColor = coaC;
b(2).EdgeColor = pcxC;
b(2).FaceColor = pcxC;
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'arial', 'fontsize', 14)


%%
option = [];
option.units = 'incrementing_by_one';
option.repetitions =500;
[performanceCoaCS1, confusionMatrixCoaCS1] = perform_linear_svm_decoding(coaCS2.esp, 1:5, option);
[performancePcxCS1, confusionMatrixPcxCS1] = perform_linear_svm_decoding(pcxCS2.esp, 1:5, option);
[performanceCoaCS2, confusionMatrixCoaCS2] = perform_linear_svm_decoding(coaCS2.esp, 6:10, option);
[performancePcxCS2, confusionMatrixPcxCS2] = perform_linear_svm_decoding(pcxCS2.esp, 6:10, option);
[performanceCoaCS3, confusionMatrixCoaCS3] = perform_linear_svm_decoding(coaCS2.esp, 11:15, option);
[performancePcxCS3, confusionMatrixPcxCS3] = perform_linear_svm_decoding(pcxCS2.esp, 11:15, option);
%% as in Fig 6J
figure
plot(mean([performancePcxCS1(:,1:80); performancePcxCS2(:,1:80); performancePcxCS3(:,1:80)]), 'color', pcxC, 'linewidth', 2);
hold on
plot(mean([performanceCoaCS1(:,1:80); performanceCoaCS2(:,1:80); performanceCoaCS3(:,1:80)]), 'color', coaC, 'linewidth', 2);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 100])
ylabel('Accuracy %')
%% as in Figs. E-F-G
n_odors = 15;
[totalSUACoa, totalResponsiveSUACoa, totalResponsiveNeuronPerOdorCoa, totalSUAExpCoa] = findNumberOfSua(coaCS2.esp, 1:n_odors, 1, 0);
[totalSUAPcx, totalResponsiveSUAPcx, totalResponsiveNeuronPerOdorPcx, totalSUAExpPcx] = findNumberOfSua(pcxCS2.esp, 1:n_odors, 1, 0);

option = [];
option.repetitions = 100;
n_odors = 15;
sua_performance_coa_odor_conc = nan(1,totalResponsiveSUACoa);
sua_MI_coa_odor_conc = nan(1,totalResponsiveSUACoa);
for idxUnit = 1:totalResponsiveSUACoa
    option.single_unit = idxUnit;
    [app, app2, app3, miApp] = perform_linear_svm_decoding(coaCS2.esp, 1:n_odors, option);
    sua_performance_coa_odor_conc(idxUnit) = mean(app);
    sua_MI_coa_odor_conc(idxUnit) = miApp;
end

sua_performance_pcx_odor_conc = nan(1,totalResponsiveSUAPcx);
sua_MI_pcx_odor_conc =  nan(1,totalResponsiveSUAPcx);
for idxUnit = 1:totalResponsiveSUAPcx
    option.single_unit = idxUnit;
    [app, app2, app3, miApp] = perform_linear_svm_decoding(pcxCS2.esp, 1:n_odors, option);
    sua_performance_pcx_odor_conc(idxUnit) = mean(app);
    sua_MI_pcx_odor_conc(idxUnit) = miApp;
end


n_odors = 15;
[totalSUACoa, totalResponsiveSUACoa, totalResponsiveNeuronPerOdorCoa, totalSUAExpCoa] = findNumberOfSua(coaCS2.esp, 1:n_odors, 1, 0);
[totalSUAPcx, totalResponsiveSUAPcx, totalResponsiveNeuronPerOdorPcx, totalSUAExpPcx] = findNumberOfSua(pcxCS2.esp, 1:n_odors, 1, 0);

option = [];
option.repetitions = 100;
option.grouping = [ones(1,5) 2*ones(1,5) 3*ones(1,5)];
n_odors = 15;
sua_performance_coa_odor = nan(1,totalResponsiveSUACoa);
sua_MI_coa_odor = nan(1,totalResponsiveSUACoa);
for idxUnit = 1:totalResponsiveSUACoa
    option.single_unit = idxUnit;
    [app, app2, app3, miApp] = perform_linear_svm_decoding(coaCS2.esp, 1:n_odors, option);
    sua_performance_coa_odor(idxUnit) = mean(app);
    sua_MI_coa_odor(idxUnit) = miApp;
end

sua_performance_pcx_odor = nan(1,totalResponsiveSUAPcx);
sua_MI_pcx_odor =  nan(1,totalResponsiveSUAPcx);
for idxUnit = 1:totalResponsiveSUAPcx
    option.single_unit = idxUnit;
    [app, app2, app3, miApp] = perform_linear_svm_decoding(pcxCS2.esp, 1:n_odors, option);
    sua_performance_pcx_odor(idxUnit) = mean(app);
    sua_MI_pcx_odor(idxUnit) = miApp;
end


n_odors = 15;
[totalSUACoa, totalResponsiveSUACoa, totalResponsiveNeuronPerOdorCoa, totalSUAExpCoa] = findNumberOfSua(coaCS2.esp, 1:5, 1, 0);
[totalSUAPcx, totalResponsiveSUAPcx, totalResponsiveNeuronPerOdorPcx, totalSUAExpPcx] = findNumberOfSua(pcxCS2.esp, 1:5, 1, 0);

option = [];
option.repetitions = 100;
n_odors = 15;
sua_performance_coa_conc1 = nan(1,totalResponsiveSUACoa);
sua_MI_coa_conc1 = nan(1,totalResponsiveSUACoa);
for idxUnit = 1:totalResponsiveSUACoa
    option.single_unit = idxUnit;
    [app, app2, app3, miApp] = perform_linear_svm_decoding(coaCS2.esp, 1:5, option);
    sua_performance_coa_conc1(idxUnit) = mean(app);
    sua_MI_coa_conc1(idxUnit) = miApp;
end

sua_performance_pcx_conc1 = nan(1,totalResponsiveSUAPcx);
sua_MI_pcx_conc1 =  nan(1,totalResponsiveSUAPcx);
for idxUnit = 1:totalResponsiveSUAPcx
    option.single_unit = idxUnit;
    [app, app2, app3, miApp] = perform_linear_svm_decoding(pcxCS2.esp, 1:5, option);
    sua_performance_pcx_conc1(idxUnit) = mean(app);
    sua_MI_pcx_conc1(idxUnit) = miApp;
end

n_odors = 15;
[totalSUACoa, totalResponsiveSUACoa, totalResponsiveNeuronPerOdorCoa, totalSUAExpCoa] = findNumberOfSua(coaCS2.esp, 6:10, 1, 0);
[totalSUAPcx, totalResponsiveSUAPcx, totalResponsiveNeuronPerOdorPcx, totalSUAExpPcx] = findNumberOfSua(pcxCS2.esp, 6:10, 1, 0);

option = [];
option.repetitions = 100;
n_odors = 15;
sua_performance_coa_conc2 = nan(1,totalResponsiveSUACoa);
sua_MI_coa_conc2 = nan(1,totalResponsiveSUACoa);
for idxUnit = 1:totalResponsiveSUACoa
    option.single_unit = idxUnit;
    [app, app2, app3, miApp] = perform_linear_svm_decoding(coaCS2.esp, 6:10, option);
    sua_performance_coa_conc2(idxUnit) = mean(app);
    sua_MI_coa_conc2(idxUnit) = miApp;
end

sua_performance_pcx_conc2 = nan(1,totalResponsiveSUAPcx);
sua_MI_pcx_conc2 =  nan(1,totalResponsiveSUAPcx);
for idxUnit = 1:totalResponsiveSUAPcx
    option.single_unit = idxUnit;
    [app, app2, app3, miApp] = perform_linear_svm_decoding(pcxCS2.esp, 6:10, option);
    sua_performance_pcx_conc2(idxUnit) = mean(app);
    sua_MI_pcx_conc2(idxUnit) = miApp;
end


n_odors = 15;
[totalSUACoa, totalResponsiveSUACoa, totalResponsiveNeuronPerOdorCoa, totalSUAExpCoa] = findNumberOfSua(coaCS2.esp, 11:15, 1, 0);
[totalSUAPcx, totalResponsiveSUAPcx, totalResponsiveNeuronPerOdorPcx, totalSUAExpPcx] = findNumberOfSua(pcxCS2.esp, 11:15, 1, 0);

option = [];
option.repetitions = 100;
n_odors = 15;
sua_performance_coa_conc3 = nan(1,totalResponsiveSUACoa);
sua_MI_coa_conc3 = nan(1,totalResponsiveSUACoa);
for idxUnit = 1:totalResponsiveSUACoa
    option.single_unit = idxUnit;
    [app, app2, app3, miApp] = perform_linear_svm_decoding(coaCS2.esp, 11:15, option);
    sua_performance_coa_conc3(idxUnit) = mean(app);
    sua_MI_coa_conc3(idxUnit) = miApp;
end

sua_performance_pcx_conc3 = nan(1,totalResponsiveSUAPcx);
sua_MI_pcx_conc3 =  nan(1,totalResponsiveSUAPcx);
for idxUnit = 1:totalResponsiveSUAPcx
    option.single_unit = idxUnit;
    [app, app2, app3, miApp] = perform_linear_svm_decoding(pcxCS2.esp, 11:15, option);
    sua_performance_pcx_conc3(idxUnit) = mean(app);
    sua_MI_pcx_conc3(idxUnit) = miApp;
end


figure
x = {sua_MI_coa_odor_conc sua_MI_pcx_odor_conc};
g = [zeros(1,length(sua_MI_coa_odor_conc)), ones(1,length(sua_MI_pcx_odor_conc))];
plotSpread(x, 'categoryIdx', g, 'categoryColors', [coaC; pcxC], 'showMM', 3)
ylabel('Information (bits)')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)


figure
x = {sua_MI_coa_odor sua_MI_pcx_odor};
g = [zeros(1,length(sua_MI_coa_odor)), ones(1,length(sua_MI_pcx_odor))];
plotSpread(x, 'categoryIdx', g, 'categoryColors', [coaC; pcxC], 'showMM', 3)
ylabel('Information (bits)')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

figure
x = {sua_MI_coa_conc1 sua_MI_pcx_conc1};
g = [zeros(1,length(sua_MI_coa_conc1)), ones(1,length(sua_MI_pcx_conc1))];
plotSpread(x, 'categoryIdx', g, 'categoryColors', [coaC; pcxC], 'showMM', 3)
ylabel('Information (bits)')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
figure
x = {sua_MI_coa_conc2 sua_MI_pcx_conc2};
g = [zeros(1,length(sua_MI_coa_conc2)), ones(1,length(sua_MI_pcx_conc2))];
plotSpread(x, 'categoryIdx', g, 'categoryColors', [coaC; pcxC], 'showMM', 3)
ylabel('Information (bits)')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
figure
x = {sua_MI_coa_conc3 sua_MI_pcx_conc3};
g = [zeros(1,length(sua_MI_coa_conc3)), ones(1,length(sua_MI_pcx_conc3))];
plotSpread(x, 'categoryIdx', g, 'categoryColors', [coaC; pcxC], 'showMM', 3)
ylabel('Information (bits)')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
%% as in Fig. 6K

odorsRearranged = 1:15;
[scoresCoa, scoresMeanCoa, explainedMeanCoa, explaineStdCoa] = findCodingSpace_new(coaCS2.esp, odorsRearranged);


figure
colorClass1 = flipud([254,240,217;...
    253,204,138;...
    252,141,89;...
    227,74,51;...
    179,0,0]./255);

colorClass2 = flipud([239,243,255;...
    189,215,231;...
    107,174,214;...
    49,130,189;...
    8,81,156]./255);

colorClass3 = flipud([237,248,233;...
    186,228,179;...
    116,196,118;...
    49,163,84;...
    0,109,44]./255);

colorClass = cat(3,colorClass1, colorClass2, colorClass3);


k = 0;
for idxOdor = 1:3
    C = squeeze(colorClass(:,:,idxOdor));
    for idxConc = 1:5
        scatter3(scoresCoa(1 + k*5:5 + k*5, 1), scoresCoa(1 + k*5:5 + k*5, 2), scoresCoa(1 + k*5:5 + k*5, 3), 100, C(idxConc,:), 'o', 'filled');
        k = k + 1;
        hold on
    end
end
xlabel('PC1');
ylabel('PC2');
zlabel('PC3');
title('plCOA');
set(gcf,'color','white', 'PaperPositionMode', 'auto');


odorsRearranged = 1:15;
[scoresPcx, scoresMeanPcx, explainedMeanPcx, explaineStdPcx] = findCodingSpace_new(pcxCS2.esp, odorsRearranged);
figure
colorClass1 = flipud([254,240,217;...
    253,204,138;...
    252,141,89;...
    227,74,51;...
    179,0,0]./255);

colorClass2 = flipud([239,243,255;...
    189,215,231;...
    107,174,214;...
    49,130,189;...
    8,81,156]./255);

colorClass3 = flipud([237,248,233;...
    186,228,179;...
    116,196,118;...
    49,163,84;...
    0,109,44]./255);
symbolOdor = {'o', 's', 'p'};
k = 0;
colorClass = cat(3,colorClass1, colorClass2, colorClass3);
for idxOdor = 1:3
    C = squeeze(colorClass(:,:,idxOdor));
    for idxConc = 1:5
        scatter3(scoresPcx(1 + k*5:5 + k*5, 1), scoresPcx(1 + k*5:5 + k*5, 2), scoresPcx(1 + k*5:5 + k*5, 3), 100, C(idxConc,:), 'o', 'filled');
        k = k + 1;
        hold on
    end
end
xlabel('PC1');
ylabel('PC2');
zlabel('PC3');
title('PCX');
set(gcf,'color','white', 'PaperPositionMode', 'auto');


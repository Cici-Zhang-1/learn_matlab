clear;
close all;

%calculate repeated measure anova

if ispc
    folder = 'F:\T2-1\Analysis\';
elseif ismac
    folder = '/Users/chuangchuangzhang/Downloads/Analysis/';
elseif isunix
else
end

filename = ['ZQ175-3W-';'ZQ175-5W-';'ZQ175-7W-'];
filename_results = 'Structure_MRI_ZQ175_Two_factors_repeated_measures_anova_results_male';
no = '2';
MW_Combine = [];
MH_Combine = [];
Combine = [];
% Brain CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule
% 'Hippocampus', 'LGP', 'Ventricles', 'AccumbensNu', 'Amygdala'
type = 'Neocortex';
for i = 1:size(filename, 1)
    MW_Combine = readtable([folder filename(i, :) no '.xlsx'], ...
        'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MW_Combine');
    MH_Combine = readtable([folder filename(i, :) no '.xlsx'], ...
        'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MH_Combine');
    Combine(1:size(MW_Combine, 2), i) = MW_Combine{type, :};
    Combine(size(MW_Combine, 2) + 1: size(MW_Combine, 2) + size(MH_Combine, 2), i) = MH_Combine{type, :};
end

Model = {'MWT' 'MWT' 'MWT' 'MWT' 'MWT' 'MWT' 'MHD' 'MHD' 'MHD' 'MHD' 'MHD' 'MHD'}';

Time = [21 35 49]';

t = table(Model, Combine(:,1), Combine(:,2), Combine(:,3), ...
'VariableNames',{'Model','P21','P35','P49'});

rm = fitrm(t,'P21-P49 ~ Model','WithinDesign',Time);
ranovatbl = ranova(rm);

writetable(ranovatbl, [folder filename_results '.xlsx'], 'WriteVariableNames', true, 'WriteRowNames', true, 'Sheet', type);

disp(ranovatbl);



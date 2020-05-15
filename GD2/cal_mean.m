clear;
close all;
% cal mean value
if ispc
    folder = 'H:\Glucoseuptake\2m\';
elseif ismac
    folder = '/Users/chuangchuangzhang/Downloads/Analysis/';
elseif isunix
else
end

filename = 'Statistics';
header = {'MH', 'MW', 'MH_std', 'MW_std', 'MH_MW_P_Value'};
names = {'Brain', 'CaudatePutamen', 'Neocortex', ...
    'Cerebellum', 'Hippocampus'};
C = cell(1, size(header, 2));
C(:) = {'double'};
mean_value = table('Size', [size(names, 2) size(header, 2)], 'VariableTypes', C,...
    'VariableNames', header, 'RowNames', names);
MH_Brain = [];
MW_Brain = [];
% CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule

MH = readtable([folder filename '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MH');
MW = readtable([folder filename '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MW');
mean_value.MH(1) = round(mean(MH{'Brain', :}, 2), 3);
mean_value.MH_std(1) = round(std(MH{'Brain', :}), 3);
mean_value.MW(1) = round(mean(MW{'Brain', :}, 2), 3);
mean_value.MW_std(1) = round(std(MW{'Brain', :}), 3);
[h,mean_value.MH_MW_P_Value(1),ci,stats] = ttest2(MH{'Brain', :}',MW{'Brain', :}', 'Vartype', 'unequal');

MH_Combine = readtable([folder filename '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MH_Combine');
MW_Combine = readtable([folder filename '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MW_Combine');
mean_value.MH(2) = round(mean(MH_Combine{'CaudatePutamen', :}, 2), 3);
mean_value.MH_std(2) = round(std(MH_Combine{'CaudatePutamen', :}), 3);
mean_value.MW(2) = round(mean(MW_Combine{'CaudatePutamen', :}, 2), 3);
mean_value.MW_std(2) = round(std(MW_Combine{'CaudatePutamen', :}), 3);

[h,mean_value.MH_MW_P_Value(2),ci,stats] = ttest2(MH_Combine{'CaudatePutamen', :}',MW_Combine{'CaudatePutamen', :}', 'Vartype', 'unequal');

mean_value.MH(3) = round(mean(MH_Combine{'Neocortex', :}, 2), 3);
mean_value.MH_std(3) = round(std(MH_Combine{'Neocortex', :}), 3);
mean_value.MW(3) = round(mean(MW_Combine{'Neocortex', :}, 2), 3);
mean_value.MW_std(3) = round(std(MW_Combine{'Neocortex', :}), 3);
[h,mean_value.MH_MW_P_Value(3),ci,stats] = ttest2(MH_Combine{'Neocortex', :}',MW_Combine{'Neocortex', :}', 'Vartype', 'unequal');

mean_value.MH(4) = round(mean(MH_Combine{'Cerebellum', :}, 2), 3);
mean_value.MH_std(4) = round(std(MH_Combine{'Cerebellum', :}), 3);
mean_value.MW(4) = round(mean(MW_Combine{'Cerebellum', :}, 2), 3);
mean_value.MW_std(4) = round(std(MW_Combine{'Cerebellum', :}), 3);
[h,mean_value.MH_MW_P_Value(4),ci,stats] = ttest2(MH_Combine{'Cerebellum', :}',MW_Combine{'Cerebellum', :}', 'Vartype', 'unequal');

mean_value.MH(5) = round(mean(MH_Combine{'Hippocampus', :}, 2), 3);
mean_value.MH_std(5) = round(std(MH_Combine{'Hippocampus', :}), 3);
mean_value.MW(5) = round(mean(MW_Combine{'Hippocampus', :}, 2), 3);
mean_value.MW_std(5) = round(std(MW_Combine{'Hippocampus', :}), 3);
[h,mean_value.MH_MW_P_Value(5),ci,stats] = ttest2(MH_Combine{'Hippocampus', :}',...
    MW_Combine{'Hippocampus', :}', 'Vartype', 'unequal');

mean_value.MH_MW_P_Value = round(mean_value.MH_MW_P_Value, 3);

writetable(mean_value, [folder filename '.xlsx'], 'WriteVariableNames', true, 'WriteRowNames', true, 'Sheet', 'Mean');



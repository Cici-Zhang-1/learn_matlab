clear;
close all;
% cal mean value
if ispc
    folder = 'F:\T2-1\Analysis\';
elseif ismac
    folder = '/Users/chuangchuangzhang/Downloads/Analysis/';
elseif isunix
else
end

filename = 'ZQ175-7W-2';
header = {'MH', 'MW', 'FH', 'FW', 'MH_std', 'MW_std', 'FH_std', 'FW_std', 'MH_MW_P_Value', 'FH_FW_P_Value', 'M_F_P_Value'};
names = {'Brain', 'CaudatePutamen', 'Neocortex', ...
    'Cerebellum', 'Thalamus', 'PeriformCortex', ...
    'Hypothalamus', 'CC/ExternalCapsule', ...
    'Hippocampus', 'LGP', 'Ventricles', 'AccumbensNu', 'Amygdala'};
C = cell(1, size(header, 2));
C(:) = {'double'};
mean_value = table('Size', [size(names, 2) size(header, 2)], 'VariableTypes', C,...
    'VariableNames', header, 'RowNames', names);
MH_Brain = [];
MW_Brain = [];
FH_Brain = [];
FW_Brain = [];
% CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule

MH = readtable([folder filename '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MH');
MW = readtable([folder filename '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MW');
FH = readtable([folder filename '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'FH');
FW = readtable([folder filename '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'FW');
mean_value.MH(1) = round(mean(MH{'Brain', :}, 2), 3);
mean_value.MH_std(1) = round(std(MH{'Brain', :}), 3);
mean_value.MW(1) = round(mean(MW{'Brain', :}, 2), 3);
mean_value.MW_std(1) = round(std(MW{'Brain', :}), 3);
mean_value.FH(1) = round(mean(FH{'Brain', :}, 2), 3);
mean_value.FH_std(1) = round(std(FH{'Brain', :}), 3);
mean_value.FW(1) = round(mean(FW{'Brain', :}, 2), 3);
mean_value.FW_std(1) = round(std(FW{'Brain', :}), 3);
[h,mean_value.MH_MW_P_Value(1),ci,stats] = ttest2(MH{'Brain', :}',MW{'Brain', :}', 'Vartype', 'unequal');
[h,mean_value.FH_FW_P_Value(1),ci,stats] = ttest2(FH{'Brain', :}',FW{'Brain', :}', 'Vartype', 'unequal');
[h,mean_value.M_F_P_Value(1),ci,stats] = ttest2((MH{'Brain', :} + FH{'Brain', :})',(MW{'Brain', :} + FW{'Brain', :})', 'Vartype', 'unequal');


MH_Combine = readtable([folder filename '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MH_Combine');
MW_Combine = readtable([folder filename '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MW_Combine');
FH_Combine = readtable([folder filename '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'FH_Combine');
FW_Combine = readtable([folder filename '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'FW_Combine');
mean_value.MH(2) = round(mean(MH_Combine{'CaudatePutamen', :}, 2), 3);
mean_value.MH_std(2) = round(std(MH_Combine{'CaudatePutamen', :}), 3);
mean_value.MW(2) = round(mean(MW_Combine{'CaudatePutamen', :}, 2), 3);
mean_value.MW_std(2) = round(std(MW_Combine{'CaudatePutamen', :}), 3);
mean_value.FH(2) = round(mean(FH_Combine{'CaudatePutamen', :}, 2), 3);
mean_value.FH_std(2) = round(std(FH_Combine{'CaudatePutamen', :}), 3);
mean_value.FW(2) = round(mean(FW_Combine{'CaudatePutamen', :}, 2), 3);
mean_value.FW_std(2) = round(std(FW_Combine{'CaudatePutamen', :}), 3);
[h,mean_value.MH_MW_P_Value(2),ci,stats] = ttest2(MH_Combine{'CaudatePutamen', :}',MW_Combine{'CaudatePutamen', :}', 'Vartype', 'unequal');
[h,mean_value.FH_FW_P_Value(2),ci,stats] = ttest2(FH_Combine{'CaudatePutamen', :}',FW_Combine{'CaudatePutamen', :}', 'Vartype', 'unequal');
[h,mean_value.M_F_P_Value(2),ci,stats] = ttest2((MH_Combine{'CaudatePutamen', :} + FH_Combine{'CaudatePutamen', :})',...
    (MW_Combine{'CaudatePutamen', :} + FW_Combine{'CaudatePutamen', :})', 'Vartype', 'unequal');

mean_value.MH(3) = round(mean(MH_Combine{'Neocortex', :}, 2), 3);
mean_value.MH_std(3) = round(std(MH_Combine{'Neocortex', :}), 3);
mean_value.MW(3) = round(mean(MW_Combine{'Neocortex', :}, 2), 3);
mean_value.MW_std(3) = round(std(MW_Combine{'Neocortex', :}), 3);
mean_value.FH(3) = round(mean(FH_Combine{'Neocortex', :}, 2), 3);
mean_value.FH_std(3) = round(std(FH_Combine{'Neocortex', :}), 3);
mean_value.FW(3) = round(mean(FW_Combine{'Neocortex', :}, 2), 3);
mean_value.FW_std(3) = round(std(FW_Combine{'Neocortex', :}), 3);
[h,mean_value.MH_MW_P_Value(3),ci,stats] = ttest2(MH_Combine{'Neocortex', :}',MW_Combine{'Neocortex', :}', 'Vartype', 'unequal');
[h,mean_value.FH_FW_P_Value(3),ci,stats] = ttest2(FH_Combine{'Neocortex', :}',FW_Combine{'Neocortex', :}', 'Vartype', 'unequal');
[h,mean_value.M_F_P_Value(3),ci,stats] = ttest2((MH_Combine{'Neocortex', :} + FH_Combine{'Neocortex', :})',...
    (MW_Combine{'Neocortex', :} + FW_Combine{'Neocortex', :})', 'Vartype', 'unequal');

mean_value.MH(4) = round(mean(MH_Combine{'Cerebellum', :}, 2), 3);
mean_value.MH_std(4) = round(std(MH_Combine{'Cerebellum', :}), 3);
mean_value.MW(4) = round(mean(MW_Combine{'Cerebellum', :}, 2), 3);
mean_value.MW_std(4) = round(std(MW_Combine{'Cerebellum', :}), 3);
mean_value.FH(4) = round(mean(FH_Combine{'Cerebellum', :}, 2), 3);
mean_value.FH_std(4) = round(std(FH_Combine{'Cerebellum', :}), 3);
mean_value.FW(4) = round(mean(FW_Combine{'Cerebellum', :}, 2), 3);
mean_value.FW_std(4) = round(std(FW_Combine{'Cerebellum', :}), 3);
[h,mean_value.MH_MW_P_Value(4),ci,stats] = ttest2(MH_Combine{'Cerebellum', :}',MW_Combine{'Cerebellum', :}', 'Vartype', 'unequal');
[h,mean_value.FH_FW_P_Value(4),ci,stats] = ttest2(FH_Combine{'Cerebellum', :}',FW_Combine{'Cerebellum', :}', 'Vartype', 'unequal');
[h,mean_value.M_F_P_Value(4),ci,stats] = ttest2((MH_Combine{'Cerebellum', :} + FH_Combine{'Cerebellum', :})',...
    (MW_Combine{'Cerebellum', :} + FW_Combine{'Cerebellum', :})', 'Vartype', 'unequal');

mean_value.MH(5) = round(mean(MH_Combine{'Thalamus', :}, 2), 3);
mean_value.MH_std(5) = round(std(MH_Combine{'Thalamus', :}), 3);
mean_value.MW(5) = round(mean(MW_Combine{'Thalamus', :}, 2), 3);
mean_value.MW_std(5) = round(std(MW_Combine{'Thalamus', :}), 3);
mean_value.FH(5) = round(mean(FH_Combine{'Thalamus', :}, 2), 3);
mean_value.FH_std(5) = round(std(FH_Combine{'Thalamus', :}), 3);
mean_value.FW(5) = round(mean(FW_Combine{'Thalamus', :}, 2), 3);
mean_value.FW_std(5) = round(std(FW_Combine{'Thalamus', :}), 3);
[h,mean_value.MH_MW_P_Value(5),ci,stats] = ttest2(MH_Combine{'Thalamus', :}',MW_Combine{'Thalamus', :}', 'Vartype', 'unequal');
[h,mean_value.FH_FW_P_Value(5),ci,stats] = ttest2(FH_Combine{'Thalamus', :}',FW_Combine{'Thalamus', :}', 'Vartype', 'unequal');
[h,mean_value.M_F_P_Value(5),ci,stats] = ttest2((MH_Combine{'Thalamus', :} + FH_Combine{'Thalamus', :})',...
    (MW_Combine{'Thalamus', :} + FW_Combine{'Thalamus', :})', 'Vartype', 'unequal');

mean_value.MH(6) = round(mean(MH_Combine{'PeriformCortex', :}, 2), 3);
mean_value.MH_std(6) = round(std(MH_Combine{'PeriformCortex', :}), 3);
mean_value.MW(6) = round(mean(MW_Combine{'PeriformCortex', :}, 2), 3);
mean_value.MW_std(6) = round(std(MW_Combine{'PeriformCortex', :}), 3);
mean_value.FH(6) = round(mean(FH_Combine{'PeriformCortex', :}, 2), 3);
mean_value.FH_std(6) = round(std(FH_Combine{'PeriformCortex', :}), 3);
mean_value.FW(6) = round(mean(FW_Combine{'PeriformCortex', :}, 2), 3);
mean_value.FW_std(6) = round(std(FW_Combine{'PeriformCortex', :}), 3);
[h,mean_value.MH_MW_P_Value(6),ci,stats] = ttest2(MH_Combine{'PeriformCortex', :}',MW_Combine{'PeriformCortex', :}', 'Vartype', 'unequal');
[h,mean_value.FH_FW_P_Value(6),ci,stats] = ttest2(FH_Combine{'PeriformCortex', :}',FW_Combine{'PeriformCortex', :}', 'Vartype', 'unequal');
[h,mean_value.M_F_P_Value(6),ci,stats] = ttest2((MH_Combine{'PeriformCortex', :} + FH_Combine{'PeriformCortex', :})',...
    (MW_Combine{'PeriformCortex', :} + FW_Combine{'PeriformCortex', :})', 'Vartype', 'unequal');

mean_value.MH(7) = round(mean(MH_Combine{'Hypothalamus', :}, 2), 3);
mean_value.MH_std(7) = round(std(MH_Combine{'Hypothalamus', :}), 3);
mean_value.MW(7) = round(mean(MW_Combine{'Hypothalamus', :}, 2), 3);
mean_value.MW_std(7) = round(std(MW_Combine{'Hypothalamus', :}), 3);
mean_value.FH(7) = round(mean(FH_Combine{'Hypothalamus', :}, 2), 3);
mean_value.FH_std(7) = round(std(FH_Combine{'Hypothalamus', :}), 3);
mean_value.FW(7) = round(mean(FW_Combine{'Hypothalamus', :}, 2), 3);
mean_value.FW_std(7) = round(std(FW_Combine{'Hypothalamus', :}), 3);
[h,mean_value.MH_MW_P_Value(7),ci,stats] = ttest2(MH_Combine{'Hypothalamus', :}',MW_Combine{'Hypothalamus', :}', 'Vartype', 'unequal');
[h,mean_value.FH_FW_P_Value(7),ci,stats] = ttest2(FH_Combine{'Hypothalamus', :}',FW_Combine{'Hypothalamus', :}', 'Vartype', 'unequal');
[h,mean_value.M_F_P_Value(7),ci,stats] = ttest2((MH_Combine{'Hypothalamus', :} + FH_Combine{'Hypothalamus', :})',...
    (MW_Combine{'Hypothalamus', :} + FW_Combine{'Hypothalamus', :})', 'Vartype', 'unequal');

mean_value.MH(8) = round(mean(MH_Combine{'CC/ExternalCapsule', :}, 2), 3);
mean_value.MH_std(8) = round(std(MH_Combine{'CC/ExternalCapsule', :}), 3);
mean_value.MW(8) = round(mean(MW_Combine{'CC/ExternalCapsule', :}, 2), 3);
mean_value.MW_std(8) = round(std(MW_Combine{'CC/ExternalCapsule', :}), 3);
mean_value.FH(8) = round(mean(FH_Combine{'CC/ExternalCapsule', :}, 2), 3);
mean_value.FH_std(8) = round(std(FH_Combine{'CC/ExternalCapsule', :}), 3);
mean_value.FW(8) = round(mean(FW_Combine{'CC/ExternalCapsule', :}, 2), 3);
mean_value.FW_std(8) = round(std(FW_Combine{'CC/ExternalCapsule', :}), 3);
[h,mean_value.MH_MW_P_Value(8),ci,stats] = ttest2(MH_Combine{'CC/ExternalCapsule', :}',MW_Combine{'CC/ExternalCapsule', :}', 'Vartype', 'unequal');
[h,mean_value.FH_FW_P_Value(8),ci,stats] = ttest2(FH_Combine{'CC/ExternalCapsule', :}',FW_Combine{'CC/ExternalCapsule', :}', 'Vartype', 'unequal');
[h,mean_value.M_F_P_Value(8),ci,stats] = ttest2((MH_Combine{'CC/ExternalCapsule', :} + FH_Combine{'CC/ExternalCapsule', :})',...
    (MW_Combine{'CC/ExternalCapsule', :} + FW_Combine{'CC/ExternalCapsule', :})', 'Vartype', 'unequal');

mean_value.MH(9) = round(mean(MH_Combine{'Hippocampus', :}, 2), 3);
mean_value.MH_std(9) = round(std(MH_Combine{'Hippocampus', :}), 3);
mean_value.MW(9) = round(mean(MW_Combine{'Hippocampus', :}, 2), 3);
mean_value.MW_std(9) = round(std(MW_Combine{'Hippocampus', :}), 3);
mean_value.FH(9) = round(mean(FH_Combine{'Hippocampus', :}, 2), 3);
mean_value.FH_std(9) = round(std(FH_Combine{'Hippocampus', :}), 3);
mean_value.FW(9) = round(mean(FW_Combine{'Hippocampus', :}, 2), 3);
mean_value.FW_std(9) = round(std(FW_Combine{'Hippocampus', :}), 3);
[h,mean_value.MH_MW_P_Value(9),ci,stats] = ttest2(MH_Combine{'Hippocampus', :}',...
    MW_Combine{'Hippocampus', :}', 'Vartype', 'unequal');
[h,mean_value.FH_FW_P_Value(9),ci,stats] = ttest2(FH_Combine{'Hippocampus', :}',...
    FW_Combine{'Hippocampus', :}', 'Vartype', 'unequal');
[h,mean_value.M_F_P_Value(9),ci,stats] = ttest2((MH_Combine{'Hippocampus', :} + ...
    FH_Combine{'Hippocampus', :})',...
    (MW_Combine{'Hippocampus', :} + FW_Combine{'Hippocampus', :})', 'Vartype', 'unequal');

mean_value.MH(10) = round(mean(MH_Combine{'LGP', :}, 2), 3);
mean_value.MH_std(10) = round(std(MH_Combine{'LGP', :}), 3);
mean_value.MW(10) = round(mean(MW_Combine{'LGP', :}, 2), 3);
mean_value.MW_std(10) = round(std(MW_Combine{'LGP', :}), 3);
mean_value.FH(10) = round(mean(FH_Combine{'LGP', :}, 2), 3);
mean_value.FH_std(10) = round(std(FH_Combine{'LGP', :}), 3);
mean_value.FW(10) = round(mean(FW_Combine{'LGP', :}, 2), 3);
mean_value.FW_std(10) = round(std(FW_Combine{'LGP', :}), 3);
[h,mean_value.MH_MW_P_Value(10),ci,stats] = ttest2(MH_Combine{'LGP', :}',...
    MW_Combine{'LGP', :}', 'Vartype', 'unequal');
[h,mean_value.FH_FW_P_Value(10),ci,stats] = ttest2(FH_Combine{'LGP', :}',...
    FW_Combine{'LGP', :}', 'Vartype', 'unequal');
[h,mean_value.M_F_P_Value(10),ci,stats] = ttest2((MH_Combine{'LGP', :} + ...
    FH_Combine{'LGP', :})',...
    (MW_Combine{'LGP', :} + FW_Combine{'LGP', :})', 'Vartype', 'unequal');

mean_value.MH(11) = round(mean(MH_Combine{'Ventricles', :}, 2), 3);
mean_value.MH_std(11) = round(std(MH_Combine{'Ventricles', :}), 3);
mean_value.MW(11) = round(mean(MW_Combine{'Ventricles', :}, 2), 3);
mean_value.MW_std(11) = round(std(MW_Combine{'Ventricles', :}), 3);
mean_value.FH(11) = round(mean(FH_Combine{'Ventricles', :}, 2), 3);
mean_value.FH_std(11) = round(std(FH_Combine{'Ventricles', :}), 3);
mean_value.FW(11) = round(mean(FW_Combine{'Ventricles', :}, 2), 3);
mean_value.FW_std(11) = round(std(FW_Combine{'Ventricles', :}), 3);
[h,mean_value.MH_MW_P_Value(11),ci,stats] = ttest2(MH_Combine{'Ventricles', :}',...
    MW_Combine{'Ventricles', :}', 'Vartype', 'unequal');
[h,mean_value.FH_FW_P_Value(11),ci,stats] = ttest2(FH_Combine{'Ventricles', :}',...
    FW_Combine{'Ventricles', :}', 'Vartype', 'unequal');
[h,mean_value.M_F_P_Value(11),ci,stats] = ttest2((MH_Combine{'Ventricles', :} + ...
    FH_Combine{'Ventricles', :})',...
    (MW_Combine{'Ventricles', :} + FW_Combine{'Ventricles', :})', 'Vartype', 'unequal');

mean_value.MH(12) = round(mean(MH_Combine{'AccumbensNu', :}, 2), 3);
mean_value.MH_std(12) = round(std(MH_Combine{'AccumbensNu', :}), 3);
mean_value.MW(12) = round(mean(MW_Combine{'AccumbensNu', :}, 2), 3);
mean_value.MW_std(12) = round(std(MW_Combine{'AccumbensNu', :}), 3);
mean_value.FH(12) = round(mean(FH_Combine{'AccumbensNu', :}, 2), 3);
mean_value.FH_std(12) = round(std(FH_Combine{'AccumbensNu', :}), 3);
mean_value.FW(12) = round(mean(FW_Combine{'AccumbensNu', :}, 2), 3);
mean_value.FW_std(12) = round(std(FW_Combine{'AccumbensNu', :}), 3);
[h,mean_value.MH_MW_P_Value(12),ci,stats] = ttest2(MH_Combine{'AccumbensNu', :}',...
    MW_Combine{'AccumbensNu', :}', 'Vartype', 'unequal');
[h,mean_value.FH_FW_P_Value(12),ci,stats] = ttest2(FH_Combine{'AccumbensNu', :}',...
    FW_Combine{'AccumbensNu', :}', 'Vartype', 'unequal');
[h,mean_value.M_F_P_Value(12),ci,stats] = ttest2((MH_Combine{'AccumbensNu', :} + ...
    FH_Combine{'AccumbensNu', :})',...
    (MW_Combine{'AccumbensNu', :} + FW_Combine{'AccumbensNu', :})', 'Vartype', 'unequal');

mean_value.MH(13) = round(mean(MH_Combine{'Amygdala', :}, 2), 3);
mean_value.MH_std(13) = round(std(MH_Combine{'Amygdala', :}), 3);
mean_value.MW(13) = round(mean(MW_Combine{'Amygdala', :}, 2), 3);
mean_value.MW_std(13) = round(std(MW_Combine{'Amygdala', :}), 3);
mean_value.FH(13) = round(mean(FH_Combine{'Amygdala', :}, 2), 3);
mean_value.FH_std(13) = round(std(FH_Combine{'Amygdala', :}), 3);
mean_value.FW(13) = round(mean(FW_Combine{'Amygdala', :}, 2), 3);
mean_value.FW_std(13) = round(std(FW_Combine{'AccumbensNu', :}), 3);
[h,mean_value.MH_MW_P_Value(13),ci,stats] = ttest2(MH_Combine{'Amygdala', :}',...
    MW_Combine{'Amygdala', :}', 'Vartype', 'unequal');
[h,mean_value.FH_FW_P_Value(13),ci,stats] = ttest2(FH_Combine{'Amygdala', :}',...
    FW_Combine{'Amygdala', :}', 'Vartype', 'unequal');
[h,mean_value.M_F_P_Value(13),ci,stats] = ttest2((MH_Combine{'Amygdala', :} + ...
    FH_Combine{'Amygdala', :})',...
    (MW_Combine{'Amygdala', :} + FW_Combine{'Amygdala', :})', 'Vartype', 'unequal');

mean_value.MH_MW_P_Value = round(mean_value.MH_MW_P_Value, 3);
mean_value.FH_FW_P_Value = round(mean_value.FH_FW_P_Value, 3);
mean_value.M_F_P_Value = round(mean_value.M_F_P_Value, 3);

writetable(mean_value, [folder filename '.xlsx'], 'WriteVariableNames', true, 'WriteRowNames', true, 'Sheet', 'Mean');



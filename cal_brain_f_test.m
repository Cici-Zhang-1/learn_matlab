clear
close all;
folder = 'F:\T2-1\Analysis\';
filename = ['ZQ175-3W-2';'ZQ175-5W-2';'ZQ175-7W-2'];
MH_Brain = [];
MW_Brain = [];
FH_Brain = [];
FW_Brain = [];
% CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule

for i = 1:size(filename, 1)
    MH = readtable([folder filename(i, :) '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MH');
    MW = readtable([folder filename(i, :) '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MW');
    FH = readtable([folder filename(i, :) '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'FH');
    FW = readtable([folder filename(i, :) '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'FW');
    MH_Brain = MH{'Brain', :};
    MW_Brain = MW{'Brain', :};
    FH_Brain = FH{'Brain', :};
    FW_Brain = FW{'Brain', :};
    [h,p,ci,stats] = vartest2(FH_Brain,FW_Brain);
%     [h,p,ci,stats] = ttest2((MH_Brain + FH_Brain)',(MW_Brain + FW_Brain)', 'Vartype', 'unequal');
    disp([filename(i, :),'p: ', num2str(p), ', h: ', num2str(h), ', fstat: ', num2str(stats.fstat)]);
end
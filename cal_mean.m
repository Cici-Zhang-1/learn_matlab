clear;
close all;

folder = 'F:\T2-1\Analysis\';
filename = 'ZQ175-3W-2';
header = {'MH', 'MW', 'FH', 'FW'};
names = {'brain', 'CaudatePutamen', 'Neocortex', ...
    'Cerebellum', 'Thalamus', 'PeriformCortex', 'Hypothalamus', 'CC/ExternalCapsule'};
C = cell(1, size(header, 2));
C(:) = {'double'};
mean_value = table('Size', [size(names, 2) size(header, 2)], 'VariableTypes', C,...
    'VariableNames', header);
MH_Brain = [];
MW_Brain = [];
FH_Brain = [];
FW_Brain = [];
% CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule

MH = readtable([folder filename '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MH');
MW = readtable([folder filename '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MW');
FH = readtable([folder filename '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'FH');
FW = readtable([folder filename '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'FW');
mean_value(1, 1) = mean(MH{'Brain', :}, 2);
mean_value(1, 2) = mean(MW{'Brain', :}, 2);
mean_value(1, 3) = mean(FH{'Brain', :}, 2);
mean_value(1, 4) = mean(FW{'Brain', :}, 2);

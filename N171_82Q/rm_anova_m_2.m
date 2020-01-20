clear;
close all;

%calculate repeated measure anova
addpath('E:\Code\ROI2\');
if ispc
    folder = 'F:\N171-82Q\Analysis\';
elseif ismac
    folder = '/Users/chuangchuangzhang/Downloads/Analysis/';
elseif isunix
else
end

filename = ['N171-82Q-3W';'N171-82Q-5W';'N171-82Q-7W'];
no = '';
MW_Combine = [];
MH_Combine = [];
Combine = [];
% Brain CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule
% 'Hippocampus', 'LGP', 'Ventricles', 'AccumbensNu', 'Amygdala'
type = 'Amygdala';
starts = 1;
ends = 0;
for i = 1:size(filename, 1)
    MW_Combine = readtable([folder filename(i, :) no '.xlsx'], ...
        'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MW_Combine');
    MH_Combine = readtable([folder filename(i, :) no '.xlsx'], ...
        'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MH_Combine');
    starts = ends + 1;
    ends = ends + size(MW_Combine, 2);
    Combine(starts:ends, 1) = MW_Combine{type, :};
    starts = ends + 1;
    ends = ends + size(MH_Combine, 2);
    Combine(starts: ends, 1) = MH_Combine{type, :};
end
S = [1:12, 1:12, 1:12]';
F1 = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3]';
F2 = [1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2]';
FACTNAMES = {'Days', 'Type'};

stats = rm_anova2(Combine,S,F1,F2,FACTNAMES);
disp(stats);
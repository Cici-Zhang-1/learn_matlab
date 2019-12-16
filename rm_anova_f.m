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
no = '2';
FW_Combine = [];
FH_Combine = [];
Combine = [];
% Brain CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule
% 'Hippocampus', 'LGP', 'Ventricles', 'AccumbensNu', 'Amygdala'
type = 'Amygdala';
for i = 1:size(filename, 1)
    FW_Combine = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'FW_Combine');
    FH_Combine = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'FH_Combine');
    Combine(1:size(FW_Combine, 2), i) = FW_Combine{type, :};
    Combine(size(FW_Combine, 2) + 1: size(FW_Combine, 2) + size(FH_Combine, 2), i) = FH_Combine{type, :};
end

Model = {'FWT' 'FWT' 'FWT' 'FWT' 'FWT' 'FWT' 'FHD' 'FHD' 'FHD' 'FHD' 'FHD' 'FHD'}';

Time = [21 35 49]';

t = table(Model, Combine(:,1), Combine(:,2), Combine(:,3), ...
'VariableNames',{'Model','P21','P35','P49'});

rm = fitrm(t,'P21-P49 ~ Model','WithinDesign',Time);
ranovatbl = ranova(rm);

disp(ranovatbl);



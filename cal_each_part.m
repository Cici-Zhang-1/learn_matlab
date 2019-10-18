clear;
close all;
folder = 'F:\T2-1\Analysis\';
filename = ['ZQ175-3W-2';'ZQ175-5W-2';'ZQ175-7W-2'];
nums = ['FH_141', 'FW_142', 'MH_143', 'FW_144', 'FH_145',...
    'FW_163', 'FW_164', 'FH_165', 'FH_166', 'MH_167', 'MH_168', ...
    'MH_169', 'MH_170', 'MW_171', 'FH_172', 'FW_174', 'MH_175', 'FH_177', 'FW_183', ...
    'MW_202', 'MW_220', 'MW_224', 'MW_225', 'MW_226'];

Combines = [];
% CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule
num = 'MW_171';
type = 'CaudatePutamen';
for i = 1:size(filename, 1)
    Combine = readtable([folder filename(i, :) '.xlsx'], 'ReadVariableNames', true,...
        'ReadRowNames', true, 'Sheet', 'Combine');
    Combines(1, i) = Combine{type, num};
end

x = [3, 5, 7];
figure;
plot(x, Combines);

legend(num);
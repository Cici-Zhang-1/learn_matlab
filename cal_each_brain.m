clear
close all;
folder = 'F:\T2-1\Analysis\';
filename = ['ZQ175-3W-2';'ZQ175-5W-2';'ZQ175-7W-2'];
nums = ['FH_141', 'FW_142', 'MH_143', 'FW_144', 'FH_145',...
    'FW_163', 'FW_164', 'FH_165', 'FH_166', 'MH_167', 'MH_168', ...
    'MH_169', 'MH_170', 'MW_171', 'FH_172', 'MW_173', 'FW_174', 'MH_175', 'FH_177', 'FW_183'];
Volumns = [];
% CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule
num = 'FW_142';
for i = 1:size(filename, 1)
    Volumn = readtable([folder filename(i, :) '.xlsx'], 'ReadVariableNames', true,...
        'ReadRowNames', true, 'Sheet', 'Volumn');
    Volumns(1, i) = Volumn{'Brain', num};
end

x = [3, 5, 7];
figure;
plot(x, Volumns);

legend(num);
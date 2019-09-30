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
    MH_Brain(1, i) = mean(MH{'Brain', :}, 2);
    MW_Brain(1, i) = mean(MW{'Brain', :}, 2);
    FH_Brain(1, i) = mean(FH{'Brain', :}, 2);
    FW_Brain(1, i) = mean(FW{'Brain', :}, 2);
end

x = [1, 2, 3];
figure;
plot(x, MH_Brain, x, MW_Brain);

legend('MH', 'MW')


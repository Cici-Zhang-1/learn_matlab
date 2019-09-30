clear
close all;
folder = 'F:\T2-1\Analysis\';
filename = ['ZQ175-3W-2';'ZQ175-5W-2';'ZQ175-7W-2'];
MH_Part = [];
MW_Part = [];
FH_Part = [];
FW_Part = [];
% CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule
type = 'CaudatePutamen';
for i = 1:size(filename, 1)
    MH = readtable([folder filename(i, :) '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MH_combine');
    MW = readtable([folder filename(i, :) '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MW_combine');
    FH = readtable([folder filename(i, :) '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'FH_combine');
    FW = readtable([folder filename(i, :) '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'FW_combine');
    MH_Part(1, i) = mean(MH{type, :}, 2);
    MW_Part(1, i) = mean(MW{type, :}, 2);
    FH_Part(1, i) = mean(FH{type, :}, 2);
    FW_Part(1, i) = mean(FW{type, :}, 2);
end

x = [1, 2, 3];
figure;
plot(x, MH_Part, x, MW_Part);

legend('MH', 'MW')


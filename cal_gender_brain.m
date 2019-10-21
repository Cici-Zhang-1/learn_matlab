clear
close all;
folder = 'F:\T2-1\Analysis\';
filename = ['ZQ175-3W-';'ZQ175-5W-';'ZQ175-7W-'];
no = '2';
MH_Brain = [];
MW_Brain = [];
FH_Brain = [];
FW_Brain = [];
% CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule

for i = 1:size(filename, 1)
    MH = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MH');
    MW = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MW');
    FH = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'FH');
    FW = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'FW');
    MH_Brain(1, i) = mean(MH{'Brain', :}, 2);
    MW_Brain(1, i) = mean(MW{'Brain', :}, 2);
    FH_Brain(1, i) = mean(FH{'Brain', :}, 2);
    FW_Brain(1, i) = mean(FW{'Brain', :}, 2);
end

HD = (MH_Brain + FH_Brain) / 2;
WT = (MW_Brain + FW_Brain) / 2;
type = 'Brain Volumn Trend';
x = [21, 35, 49];
figure;
plot(x, HD, 'k+', x, WT, 'ro');
title(type);

xlim([20 50]);
% ylim([16 20]);
% yticks([16 17 18 19 20])
xticks([21 35 49])

xlabel('Days');
ylabel('Volumn(mm^3)');

p = polyfit(x, HD, 2);
x1 = linspace(21,49)';
yMH = polyval(p,x1);
hold on
p1 = plot(x1,yMH, 'k');
hold off

p = polyfit(x, WT, 2);
x1 = linspace(21,49)';
yWT = polyval(p,x1);
hold on
p2 = plot(x1,yWT, 'r');
hold off

legend([p1 p2],{'MH', 'MW'}, 'Location', 'northeastoutside');

saveas(gcf,sprintf('HD_WT_%s.png', type))
clear
close all;
% folder = 'F:\T2-1\Analysis\';
folder = '/Users/chuangchuangzhang/Downloads/Analysis/';
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

type = 'Brain Volumn Trend';
x = [21, 35, 49];
figure;
plot(x, MH_Brain, 'k+', x, MW_Brain, 'ro', x, FH_Brain, 'g*', x, FW_Brain, 'bs');
title(type);

xlim([20 50]);
% ylim([16 20]);
% yticks([16 17 18 19 20])
xticks([21 35 49])

xlabel('Days');
ylabel('Volumn(mm^3)');

p = polyfit(x, MH_Brain, 2);
x1 = linspace(21,49)';
yMH = polyval(p,x1);
hold on
p1 = plot(x1,yMH, 'k');
hold off

p = polyfit(x, MW_Brain, 2);
x1 = linspace(21,49)';
yMW = polyval(p,x1);
hold on
p2 = plot(x1,yMW, 'r');
hold off

p = polyfit(x, FH_Brain, 2);
x1 = linspace(21,49)';
yFH = polyval(p,x1);
hold on
p3 = plot(x1,yFH, 'g');
hold off

p = polyfit(x, FW_Brain, 2);
x1 = linspace(21,49)';
yFW = polyval(p,x1);
hold on
p4 = plot(x1,yFW, 'b');
hold off

legend([p1 p2 p3 p4],{'MH', 'MW', 'FH', 'FW'}, 'Location', 'northeastoutside');

saveas(gcf,sprintf('%s.png', type))


clear
close all;
folder = 'F:\T2-1\Analysis\';
filename = ['ZQ175-3W-';'ZQ175-5W-';'ZQ175-7W-'];
no = '2';
MH_Part = [];
MW_Part = [];
FH_Part = [];
FW_Part = [];
% CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule
type = 'CC/ExternalCapsule';
for i = 1:size(filename, 1)
    MH = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MH_combine');
    MW = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MW_combine');
    FH = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'FH_combine');
    FW = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'FW_combine');
    MH_Part(1, i) = mean(MH{type, :}, 2);
    MW_Part(1, i) = mean(MW{type, :}, 2);
    FH_Part(1, i) = mean(FH{type, :}, 2);
    FW_Part(1, i) = mean(FW{type, :}, 2);
end

HD = (MH_Part + FH_Part)/2;
WT = (MW_Part + FW_Part)/2;

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
yHD = polyval(p,x1);
hold on
p1 = plot(x1,yHD, 'k');
hold off

p = polyfit(x, WT, 2);
x1 = linspace(21,49)';
yWT = polyval(p,x1);
hold on
p2 = plot(x1,yWT, 'r');
hold off

legend([p1 p2],{'HD', 'WT'}, 'Location', 'northeastoutside');

saveas(gcf,sprintf('HD_WT_%s.png', type))

% legend('MH', 'MW', 'FH', 'FW', 'MH-', 'MW-', 'FH-', 'FW-');


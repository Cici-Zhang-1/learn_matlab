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
type = 'CaudatePutamen';
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

x = [21, 35, 49];
figure;
plot(x, MH_Part, 'k+', x, MW_Part, 'ro', x, FH_Part, 'g*', x, FW_Part, 'bs');

title(type);

xlim([20 50]);
% ylim([16 20]);
% yticks([16 17 18 19 20])
xticks([21 35 49])

xlabel('Days');
ylabel('Volumn(mm^3)');

p = polyfit(x, MH_Part, 2);
x1 = linspace(21,49)';
yMH = polyval(p,x1);
hold on
p1 = plot(x1,yMH, 'k');
hold off

xconf = [x1' x1(end:-1:1)'] ;         
yconf = [yMH'+0.15 yMH(end:-1:1)'-0.15];

hold on
pC = fill(xconf,yconf,'red');
pC.FaceColor = [1 0.8 0.8];      
pC.EdgeColor = 'none'; 
hold off

legend([p1 p2 p3 p4],{'MH', 'MW', 'FH', 'FW'}, 'Location', 'northeastoutside');

saveas(gcf,sprintf('%s.png', type))

% legend('MH', 'MW', 'FH', 'FW', 'MH-', 'MW-', 'FH-', 'FW-');


clear
close all;
folder = '/Users/chuangchuangzhang/Downloads/Analysis/';
filename = ['ZQ175-3W-';'ZQ175-5W-';'ZQ175-7W-'];
no = '2';
MH_Part = [];
MH_Up_Part = [];
MH_Down_Part = [];
MW_Part = [];
MW_Up_Part = [];
MW_Down_Part = [];
FH_Part = [];
FH_Up_Part = [];
FH_Down_Part = [];
FW_Part = [];
FW_Up_Part = [];
FW_Down_Part = [];
% CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule
type = 'CaudatePutamen';
for i = 1:size(filename, 1)
%     MH = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MH_combine');
%     MW = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MW_combine');
%     FH = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'FH_combine');
%     FW = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'FW_combine');
%     MH_Part(1, i) = mean(MH{type, :}, 2);
%     MW_Part(1, i) = mean(MW{type, :}, 2);
%     FH_Part(1, i) = mean(FH{type, :}, 2);
%     FW_Part(1, i) = mean(FW{type, :}, 2);
    Mean = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'Mean');
    MH_Part(1, i) = Mean{type, 'MH'};
    t = Mean{type, 'MH_std'};
    MH_Up_Part(1, i) = MH_Part(1, i) + t;
    MH_Down_Part(1, i) = MH_Part(1, i) - t;
    MW_Part(1, i) = Mean{type, 'MW'};
    t = Mean{type, 'MW_std'};
    MW_Up_Part(1, i) = MW_Part(1, i) + t;
    MW_Down_Part(1, i) = MW_Part(1, i) - t;
    FH_Part(1, i) = Mean{type, 'FH'};
    t = Mean{type, 'FH_std'};
    FH_Up_Part(1, i) = FH_Part(1, i) + t;
    FH_Down_Part(1, i) = FH_Part(1, i) - t;
    FW_Part(1, i) = Mean{type, 'FW'};
    t = Mean{type, 'FW_std'};
    FW_Up_Part(1, i) = FW_Part(1, i) + t;
    FW_Down_Part(1, i) = FW_Part(1, i) - t;
end

x = [21, 35, 49];
figure;

x1 = linspace(21,49)';
%MW
p = polyfit(x, MW_Part, 2);
yMW = polyval(p,x1);

p = polyfit(x, MW_Up_Part, 2);
yup = polyval(p, x1);
p = polyfit(x, MW_Down_Part, 2);
ydown = polyval(p, x1);

xconf = [x1' x1(end:-1:1)'];         
yconf = [ydown' yup(end:-1:1)'];

pC = fill(xconf,yconf,'green');
pC.FaceColor = [0.77 0.9 0.875];      
pC.EdgeColor = 'none'; 
pC.FaceAlpha = 0.6;
%MH
p = polyfit(x, MH_Part, 2);

yMH = polyval(p,x1);

p = polyfit(x, MH_Up_Part, 2);
yup = polyval(p, x1);
p = polyfit(x, MH_Down_Part, 2);
ydown = polyval(p, x1);

xconf = [x1' x1(end:-1:1)'] ;         
yconf = [ydown' yup(end:-1:1)'];

hold on
pC = fill(xconf,yconf,'red');
pC.FaceColor = [0.97 0.85 0.85];      
pC.EdgeColor = 'none'; 
pC.FaceAlpha = 0.6;
hold off

hold on
p1 = plot(x1,yMW, 'Color', [0 0.66 0.52], 'LineWidth', 3);
hold off

hold on
p2 = plot(x1,yMH, 'Color', [0.9 0.38 0.38], 'LineWidth', 3);
hold off

title(type);
xlim([20 50]);
xticks([21 35 49])
xlabel('Days');
ylabel('Volumn(mm^3)');

legend([p1 p2],{'MW', 'MH'}, 'Location', 'northeastoutside');

saveas(gcf,sprintf('%s.png', type))

% legend('MH', 'MW', 'FH', 'FW', 'MH-', 'MW-', 'FH-', 'FW-');

% %FW
% [0.13 0.46 0.54]
% [0.79 0.87 0.89]
% %FH
% [0.69 0.164 0.531]
% [0.926 0.79 0.86]


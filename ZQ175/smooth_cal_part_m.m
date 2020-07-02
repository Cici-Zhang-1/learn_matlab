clear;
close all;
if ispc
    folder = 'F:\T2-1\Analysis\';
elseif ismac
    folder = '/Users/chuangchuangzhang/Documents/Data/StructureMRI/ZQ175/';
elseif isunix
else
end

filename = ['ZQ175-3W-';'ZQ175-5W-';'ZQ175-7W-'];
no = '2';
MH_Part = [];
MH_Up_Part = [];
MH_Down_Part = [];
MW_Part = [];
MW_Up_Part = [];
MW_Down_Part = [];
% Brain CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule
type = 'CaudatePutamen';
for i = 1:size(filename, 1)
    Mean = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'Mean');
    MH_Part(1, i) = Mean{type, 'MH'};
    t = Mean{type, 'MH_std'};
    MH_Up_Part(1, i) = MH_Part(1, i) + t;
    MH_Down_Part(1, i) = MH_Part(1, i) - t;
    MW_Part(1, i) = Mean{type, 'MW'};
    t = Mean{type, 'MW_std'};
    MW_Up_Part(1, i) = MW_Part(1, i) + t;
    MW_Down_Part(1, i) = MW_Part(1, i) - t;
end

x = [21, 35, 49];
figure;

x1 = linspace(21,49)';
smoothtype = 'poly2';
%MW
[cMW, gof, output] = fit(x', MW_Part', smoothtype);
yMW = feval(cMW, x1);
[cMW_Up, gof, output] = fit(x', MW_Up_Part', smoothtype);
yup = feval(cMW_Up, x1);
[cMW_Down, gof, output] = fit(x', MW_Down_Part', smoothtype);
ydown = feval(cMW_Down, x1);

xconf = [x1' x1(end:-1:1)'];         
yconf = [ydown' yup(end:-1:1)'];

pC = fill(xconf,yconf,'green');
pC.FaceColor = [0.77 0.9 0.875];      
pC.EdgeColor = 'none'; 
pC.FaceAlpha = 0.6;
%MH
[cMH, gof, output] = fit(x', MH_Part', smoothtype);
yMH = feval(cMH, x1);
[cMH_Up, gof, output] = fit(x', MH_Up_Part', smoothtype);
yup = feval(cMH_Up, x1);
[cMH_Down, gof, output] = fit(x', MH_Down_Part', smoothtype);
ydown = feval(cMH_Down, x1);

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

xlim([20 50]);
xticks([21 35 49]);
% Brain CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule
if strcmp(type, 'CaudatePutamen')
%     ylim([14 22]);
    ylim([16 21]);
elseif strcmp(type, 'Neocortex')
%     ylim([70 110])
    ylim([75 100]);
elseif strcmp(type, 'Cerebellum')
%     ylim([30 70]);
    ylim([40 60]);
elseif strcmp(type, 'Thalamus')
%     ylim([15 28]);
    ylim([18 24]);
elseif strcmp(type, 'PeriformCortex')
    ylim([1 5]);
elseif strcmp(type, 'Hypothalamus')
    ylim([6 16]);
elseif strcmp(type, 'CC/ExternalCapsule')
    ylim([8 16]);
elseif strcmp(type, 'Brain')
    ylim([350 500]);
else
end
% ylim([15 25]);
xlabel('Days', 'FontSize', 18);
ylabel('Volumn(mm^3)', 'FontSize', 18);

ax = gca; % current axes
ax.FontSize = 16;

lgd = legend([p1 p2],{'WT', 'HD'}, 'Location', 'northwest', 'FontSize', 12);
legend('boxoff');
title(lgd, ['Male ' type]);

if strcmp(type, 'CC/ExternalCapsule')
    saveas(gcf,sprintf('M_%s.png', 'CC_ExternalCapsule'))
else
    saveas(gcf,sprintf('M_%s.png', type))
end

% legend('MH', 'MW', 'FH', 'FW', 'MH-', 'MW-', 'FH-', 'FW-');

% %FW
% [0.13 0.46 0.54]
% [0.79 0.87 0.89]
% %FH
% [0.69 0.164 0.531]
% [0.926 0.79 0.86]


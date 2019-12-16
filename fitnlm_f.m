clear;
close all;

%Fit nonlinear regression model

if ispc
    folder = 'F:\T2-1\Analysis\';
elseif ismac
    folder = '/Users/chuangchuangzhang/Downloads/Analysis/';
elseif isunix
else
end

filename = ['ZQ175-3W-';'ZQ175-5W-';'ZQ175-7W-'];
no = '2';
FW_Combine = [];
FW = [];
FH_Combine = [];
FH = [];
Combine = [];
% Brain CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule
% 'Hippocampus', 'LGP', 'Ventricles', 'AccumbensNu', 'Amygdala'

type = 'Hippocampus';
starts = 0;
for i = 1:size(filename, 1)
    FW_Combine = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'FW_Combine');
    FH_Combine = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'FH_Combine');
    ends = starts + size(FW_Combine, 2);
    starts = starts + 1;
    FW(starts:ends, 1) = FW_Combine{type, :};
    FH(starts:ends, 1) = FH_Combine{type, :};
    starts = ends;
end

x = [repmat(21, 6, 1); repmat(35, 6, 1); repmat(49, 6, 1)];

model = @(b, t) b(:, 1).*t.^2 + b(:, 2).*t + b(:, 3);

opts = statset('nlinfit');
opts.RobustWgtFun = 'bisquare';

beta0 = [1 1 20];
x1 = linspace(21,49)';
mdl = fitnlm(x,FW,model,beta0, 'Options', opts);
[yFW,yci] = predict(mdl,x1);
yup = yci(:, 2);
ydown = yci(:, 1);

xconf = [x1' x1(end:-1:1)'];         
yconf = [ydown' yup(end:-1:1)'];

pC = fill(xconf,yconf,'green');
pC.FaceColor = [0.77 0.9 0.875];      
pC.EdgeColor = 'none'; 
pC.FaceAlpha = 0.6;

hold on;

mdl = fitnlm(x,FH,model,beta0);
[yFH,yci] = predict(mdl,x1);
yup = yci(:, 2);
ydown = yci(:, 1);

xconf = [x1' x1(end:-1:1)'];         
yconf = [ydown' yup(end:-1:1)'];

pC = fill(xconf,yconf,'red');
pC.FaceColor = [0.97 0.85 0.85];      
pC.EdgeColor = 'none'; 
pC.FaceAlpha = 0.6;

p1 = plot(x1,yFW, 'Color', [0 0.66 0.52], 'LineWidth', 3);
p2 = plot(x1,yFH, 'Color', [0.9 0.38 0.38], 'LineWidth', 3);

xlim([20 50]);
xticks([21 35 49]);
% Brain CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule
% 'Hippocampus', 'LGP', 'Ventricles', 'AccumbensNu', 'Amygdala'
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
elseif strcmp(type, 'Hippocampus')
    ylim([19 25]);
elseif strcmp(type, 'LGP')
    ylim([1.3 1.9]);
elseif strcmp(type, 'Ventricles')
    ylim([7 13]);
elseif strcmp(type, 'AccumbensNu')
    ylim([1.4 1.9]);
elseif strcmp(type, 'Amygdala')
    ylim([3.5 6.5]);
else
end
% ylim([15 25]);
xlabel('Days', 'FontSize', 18);
ylabel('Volumn(mm^3)', 'FontSize', 18);

ax = gca; % current axes
ax.FontSize = 16;

lgd = legend([p1 p2],{'WT', 'HD'}, 'Location', 'northwest', 'FontSize', 12);
legend('boxoff');
title(lgd, ['Female ' type]);

if strcmp(type, 'CC/ExternalCapsule')
    saveas(gcf,sprintf('F_%s.png', 'CC_ExternalCapsule'))
else
    saveas(gcf,sprintf('F_%s.png', type))
end

clear;
close all;

%Fit nonlinear regression model

if ispc
    folder = 'F:\N171-82Q\Analysis\';
elseif ismac
    folder = '/Users/chuangchuangzhang/Downloads/Analysis/';
elseif isunix
else
end

filename = ['N171-82Q-3W';'N171-82Q-5W';'N171-82Q-7W'];
no = '';
MW_Combine = [];
MW = [];
MH_Combine = [];
MH = [];
Combine = [];
% Brain CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule
% 'Hippocampus', 'LGP', 'Ventricles', 'AccumbensNu', 'Amygdala'

type = 'CaudatePutamen';
starts = 0;
for i = 1:size(filename, 1)
    MW_Combine = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MW_Combine');
    MH_Combine = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MH_Combine');
    ends = starts + size(MW_Combine, 2);
    starts = starts + 1;
    MW(starts:ends, 1) = MW_Combine{type, :};
    MH(starts:ends, 1) = MH_Combine{type, :};
    starts = ends;
end

x = [repmat(21, 6, 1); repmat(35, 6, 1); repmat(49, 6, 1)];

model = @(b, t) b(:, 1).*t.^2 + b(:, 2).*t + b(:, 3);

opts = statset('nlinfit');
opts.RobustWgtFun = 'bisquare';

beta0 = [1 1 20];
x1 = linspace(21,49)';
mdl = fitnlm(x,MW,model,beta0, 'Options', opts);
[yMW,yci] = predict(mdl,x1);
yup = yci(:, 2);
ydown = yci(:, 1);

xconf = [x1' x1(end:-1:1)'];         
yconf = [ydown' yup(end:-1:1)'];

pC = fill(xconf,yconf,'green');
pC.FaceColor = [0.77 0.9 0.875];      
pC.EdgeColor = 'none'; 
pC.FaceAlpha = 0.6;

hold on;

mdl = fitnlm(x,MH,model,beta0);
[yMH,yci] = predict(mdl,x1);
yup = yci(:, 2);
ydown = yci(:, 1);

xconf = [x1' x1(end:-1:1)'];         
yconf = [ydown' yup(end:-1:1)'];

pC = fill(xconf,yconf,'red');
pC.FaceColor = [0.97 0.85 0.85];      
pC.EdgeColor = 'none'; 
pC.FaceAlpha = 0.6;

p1 = plot(x1,yMW, 'Color', [0 0.66 0.52], 'LineWidth', 3);
p2 = plot(x1,yMH, 'Color', [0.9 0.38 0.38], 'LineWidth', 3);

xlim([20 50]);
xticks([21 35 49]);
% Brain CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule
% 'Hippocampus', 'LGP', 'Ventricles', 'AccumbensNu', 'Amygdala'
if strcmp(type, 'CaudatePutamen')
%     ylim([14 22]);
    ylim([16 25]);
elseif strcmp(type, 'Neocortex')
%     ylim([70 110])
    ylim([75 110]);
elseif strcmp(type, 'Cerebellum')
%     ylim([30 70]);
    ylim([40 80]);
elseif strcmp(type, 'Thalamus')
%     ylim([15 28]);
    ylim([18 28]);
elseif strcmp(type, 'PeriformCortex')
    ylim([1 5]);
elseif strcmp(type, 'Hypothalamus')
    ylim([6 16]);
elseif strcmp(type, 'CC/ExternalCapsule')
    ylim([8 16]);
elseif strcmp(type, 'Brain')
    ylim([350 520]);
elseif strcmp(type, 'Hippocampus')
    ylim([18 26]);
elseif strcmp(type, 'LGP')
    ylim([1.3 2.3]);
elseif strcmp(type, 'Ventricles')
    ylim([7 12]);
elseif strcmp(type, 'AccumbensNu')
    ylim([1.4 2.0]);
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
if strcmp(type, 'LGP')
    title(lgd, 'Male Lateral Globus Pallidus');
else
    title(lgd, ['Male ' type]);
end

if strcmp(type, 'CC/ExternalCapsule')
    saveas(gcf,sprintf('%sM_%s.png', folder, 'CC_ExternalCapsule'))
else
    saveas(gcf,sprintf('%sM_%s.png', folder, type))
end

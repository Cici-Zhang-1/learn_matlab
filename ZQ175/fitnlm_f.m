clear;
close all;

%Fit nonlinear regression model

if ispc
    folder = 'F:\T2-1\Analysis\';
elseif ismac
    folder = '/Users/chuangchuangzhang/Documents/Data/StructureMRI/ZQ175/';
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

type = 'LGP';
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

x = [repmat(3, 6, 1); repmat(5, 6, 1); repmat(7, 6, 1)];

model = @(b, t) b(:, 1).*t.^2 + b(:, 2).*t + b(:, 3);

opts = statset('nlinfit');
opts.RobustWgtFun = 'bisquare';

beta0 = [1 1 20];
x1 = linspace(3,7, 29)';
mdlW = fitnlm(x,FW,model,beta0, 'Options', opts);
disp(mdlW);
[yFW,yci] = predict(mdlW,x1);
yup = yci(:, 2);
ydown = yci(:, 1);

xconf = [x1' x1(end:-1:1)'];         
yconf = [ydown' yup(end:-1:1)'];

pC = fill(xconf,yconf,'green');
pC.FaceColor = [0.79 0.87 0.89];      
pC.EdgeColor = 'none'; 
pC.FaceAlpha = 0.6;

hold on;

mdl = fitnlm(x,FH,model,beta0, 'Options', opts);
disp(mdl);
[yFH,yci] = predict(mdl,x1);
yup = yci(:, 2);
ydown = yci(:, 1);

xconf = [x1' x1(end:-1:1)'];         
yconf = [ydown' yup(end:-1:1)'];

pC = fill(xconf,yconf,'red');
pC.FaceColor = [0.926 0.79 0.86];      
pC.EdgeColor = 'none'; 
pC.FaceAlpha = 0.6;

p1 = plot(x1,yFW, 'Color', [0.13 0.46 0.54], 'LineWidth', 3);
p2 = plot(x1,yFH, 'Color', [0.69 0.164 0.531], 'LineWidth', 3);


xlim([2.8 7.2]);
xticks([3 5 7]);
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
xlabel('Weeks', 'FontSize', 18);
ylabel('Volume(mm^3)', 'FontSize', 18);

ax = gca; % current axes
ax.FontSize = 16;

lgd = legend([p1 p2],{'WT', 'HD'}, 'Location', 'northwest', 'FontSize', 12);
legend('boxoff');

if strcmp(type, 'LGP')
    title(lgd, 'Female Lateral Globus Pallidus');
elseif strcmp(type, 'CaudatePutamen')
    title(lgd, 'Female Striatum');
else
    title(lgd, ['Female ' type]);
end

if strcmp(type, 'CC/ExternalCapsule')
    saveas(gcf,sprintf('%sF_%s.png', folder, 'CC_ExternalCapsule'))
else
    saveas(gcf,sprintf('%sF_%s.png', folder, type))
end

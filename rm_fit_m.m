clear;
close all;

%calculate repeated measure anova

if ispc
    folder = 'F:\T2-1\Analysis\';
elseif ismac
    folder = '/Users/chuangchuangzhang/Downloads/Analysis/';
elseif isunix
else
end

filename = ['ZQ175-3W-';'ZQ175-5W-';'ZQ175-7W-'];
no = '2';
MW_Combine = [];
MH_Combine = [];
Combine = [];
% Brain CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule
type = 'CaudatePutamen';
for i = 1:size(filename, 1)
    MW_Combine = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MW_Combine');
    MH_Combine = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MH_Combine');
    Combine(1:size(MW_Combine, 2), i) = MW_Combine{type, :};
    Combine(size(MW_Combine, 2) + 1: size(MW_Combine, 2) + size(MH_Combine, 2), i) = MH_Combine{type, :};
end

Model = {'MWT' 'MWT' 'MWT' 'MWT' 'MWT' 'MWT' 'MHD' 'MHD' 'MHD' 'MHD' 'MHD' 'MHD'}';

Time = [21 35 49]';

t = table(Model, Combine(:,1), Combine(:,2), Combine(:,3), ...
'VariableNames',{'Model','P21','P35','P49'});

rm = fitrm(t,'P21-P49 ~ Model','WithinDesign',Time, 'WithinModel', 'orthogonalcontrasts');

time = linspace(21, 49)';
[Y, ypredci] = predict(rm,t([3 11],:), ...
    'WithinModel','orthogonalcontrasts','WithinDesign',time, 'alpha', 0.05);
% p1 = plotprofile(rm,'Time','Group',{'Model'});
p1 = plot(time, Y(1, :), 'Color', [0 0.66 0.52], 'LineWidth', 3);
hold on; 
p2 = plot(time, Y(2, :), 'Color', [0.9 0.38 0.38], 'LineWidth', 3);
% p3 = plot(time,ypredci(1,:,1),'k--');
% p4 = plot(time,ypredci(1,:,2),'k--');
% p5 = plot(time, ypredci(2, :, 1), 'k-.');
% p6 = plot(time, ypredci(2, :, 2), 'k-.');
% legend([p1;p2(1);p3(1)],'Gender=F','Gender=M','Predictions','Confidence Intervals')
xconf = [time' time(end:-1:1)'];
yconf = [ypredci(1,:,1) ypredci(1, end:-1:1, 2)];

pC = fill(xconf,yconf,'green');
pC.FaceColor = [0.77 0.9 0.875];      
pC.EdgeColor = 'none'; 
pC.FaceAlpha = 0.6;

yconf = [ypredci(2,:,1) ypredci(2, end:-1:1, 2)];

pC = fill(xconf,yconf,'red');
pC.FaceColor = [0.97 0.85 0.85];      
pC.EdgeColor = 'none'; 
pC.FaceAlpha = 0.6;

xlim([20 50]);
xticks([21 35 49]);
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
hold off
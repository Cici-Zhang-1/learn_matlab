clear
close all;
folder = '/Users/chuangchuangzhang/Downloads/Analysis/';
filename = ['ZQ175-3W-';'ZQ175-5W-';'ZQ175-7W-'];
no = '2';
Segment = [];
e = [];

% CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule
type = 'Brain';
for i = 1:size(filename, 1)
    MH = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MH');
    MW = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MW');
    FH = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'FH');
    FW = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'FW');
    mean_value = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'Mean');
    Segment(i, 1) = mean(MH{type, :}, 2);
    Segment(i, 2) = mean(MW{type, :}, 2);
    Segment(i, 3) = mean(FH{type, :}, 2);
    Segment(i, 4) = mean(FW{type, :}, 2);
    e(i, 1) = mean_value{type, 'MH_std'};
    e(i, 2) = mean_value{type, 'MW_std'};
    e(i, 3) = mean_value{type, 'FH_std'};
    e(i, 4) = mean_value{type, 'FW_std'};
end

% x = [1, 2, 3];
figure;
b = bar(Segment, 'grouped', 'FaceColor','flat');
set(gca, 'XTickLabel',{'21', '35', '49'}, 'FontSize', 15);
ylim([380 480]);
xlabel('Days');
ylabel('Volumn(mm^3)');

title(type);

% e = [0.0198, 0.0124, 0.0096, 0.0112; 0.0875, 0.0990, 0.1034, 0.0939; 0.0875, 0.0990, 0.1034, 0.0939];
hold on
numgroups = size(Segment, 1);
numbars = size(Segment, 2);
groupwidth = min(0.8, numbars/(numbars+1.5));
colors = [0 0 0; 1 0 0; 0 1 0; 0 0 1];
for i = 1:numbars
	% Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
	x1 = (1:numgroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*numbars); % Aligning error bar with individual bar
	errorbar(x1, Segment(:,i), e(:,i), 'k', 'linestyle', 'none', 'lineWidth', 1);
    b(i).CData = colors(i, :);
end

legend({'MH', 'MW', 'FH', 'FW'}, 'Location', 'northeastoutside');
saveas(gcf,sprintf('cal_brain_bar_%s.png', type));

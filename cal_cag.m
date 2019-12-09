clear;
close all;

FemaleData = [227 220 223 227 227 225];
MaleData = [221 220 227 219 223 225];

MeanFemaleData = mean(FemaleData);
MeanMaleData = mean(MaleData);
StdFemaleData = std(FemaleData);
StdMaleData = std(MaleData);

y = [MeanMaleData; MeanFemaleData];
e = [StdMaleData; StdFemaleData];

bar(y, 'w');
set(gca,'YLim', [210,235], 'XTickLabel',{'Male', 'Female'}, 'FontSize', 18);
ylabel('CAG', 'FontSize', 18);
ax = gca; % current axes
ax.FontSize = 16;
% title('CAG Repeat Size');
hold on
errorbar([1, 2], y, e, 'k', 'linestyle', 'none', 'lineWidth', 1);
hold off;
clear;
close all;

hdData = [1.000 0.630 0.470];
wtData = [0.730 0.600 0.930];

hdMeanData = mean(hdData);
wtMeanData = mean(wtData);
hdStdData = std(hdData);
wtStdData = std(wtData);

y = [hdMeanData; wtMeanData];
e = [hdStdData; wtStdData];

bar(y, 'w');
set(gca,'YLim', [0,2], 'XTickLabel',{'HD', 'WT'}, 'FontSize', 18);
ylabel('Darpp32/Beta-actin', 'FontSize', 18);
ax = gca; % current axes
ax.FontSize = 16;
% title('CAG Repeat Size');
hold on
errorbar([1, 2], y, e, 'k', 'linestyle', 'none', 'lineWidth', 1);
hold off;

% FemaleData = [227 220 223 227 227 225];
% MaleData = [221 220 227 219 223 225];
% 
% MeanFemaleData = mean(FemaleData);
% MeanMaleData = mean(MaleData);
% StdFemaleData = std(FemaleData);
% StdMaleData = std(MaleData);
% 
% y = [MeanMaleData; MeanFemaleData];
% e = [StdMaleData; StdFemaleData];
% 
% bar(y, 'w');
% set(gca,'YLim', [210,235], 'XTickLabel',{'Male', 'Female'}, 'FontSize', 18);
% ylabel('CAG', 'FontSize', 18);
% ax = gca; % current axes
% ax.FontSize = 16;
% % title('CAG Repeat Size');
% hold on
% errorbar([1, 2], y, e, 'k', 'linestyle', 'none', 'lineWidth', 1);
% hold off;
% a_live = [0.9186, 0.9460, 0.9552, 0.9533];
% a_tid = [0.6090, 0.6663, 0.7170, 0.7165];
% a = [a_live; a_tid];
% bar(a, 'grouped')
% set(gca,'YLim', [0.5,1], 'XTickLabel',{'LIVE', 'TID2013'}, 'FontSize', 15);
% ylabel('SRC');
% set(gca, 'Ytick', 0.5:0.05:1, 'ygrid','on','GridLineStyle','-');
% legend('25','50','100','200', 'Location', 'EastOutside');
% legend('boxoff');
% e = [0.0198, 0.0124, 0.0096, 0.0112; 0.0875, 0.0990, 0.1034, 0.0939];
% hold on
% numgroups = size(a, 1);
% numbars = size(a, 2);
% groupwidth = min(0.8, numbars/(numbars+1.5));
% for i = 1:numbars
% 	% Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
% 	x = (1:numgroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*numbars); % Aligning error bar with individual bar
% 	errorbar(x, a(:,i), e(:,i), 'k', 'linestyle', 'none', 'lineWidth', 1);
% end

% x = 1:13;
% data = [37.6 24.5 14.6 18.1 19.5 8.1 28.5 7.9 3.3 4.1 7.9 1.9 4.3]';
% errhigh = [2.1 4.4 0.4 3.3 2.5 0.4 1.6 0.8 0.6 0.8 2.2 0.9 1.5];
% errlow  = [4.4 2.4 2.3 0.5 1.6 1.5 4.5 1.5 0.4 1.2 1.3 0.8 1.9];
% 
% bar(x,data)                
% 
% hold on
% 
% er = errorbar(x,data,errlow);    
% er.Color = [0 0 0];                            
% er.LineStyle = 'none';  
% 
% hold off

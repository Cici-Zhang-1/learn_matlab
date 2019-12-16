clear;
close all;

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
MW = [];
MH_Combine = [];
MH = [];
Combine = [];
% Brain CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule
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
model_1 = @(b, t) b(1, 1).*t.^2 + b(2, 1).*t + b(3, 1);

beta0 = [1 1 20];
x1 = linspace(21,49)';

NUMS = repmat((1:6)', 3, 1);

[beta2,PSI2,stats2,b2] = nlmefit(x, MW, NUMS(:), [], model, beta0);

[yMW,delta] = nlpredci(model_1,x1,beta2,stats2.cwres, 'Covar',stats2.covb,...
                         'MSE',stats2.mse);
yup = yMW + delta;
ydown = yMW - delta;

xconf = [x1' x1(end:-1:1)'];         
yconf = [ydown' yup(end:-1:1)'];

pC = fill(xconf,yconf,'green');
pC.FaceColor = [0.77 0.9 0.875];      
pC.EdgeColor = 'none'; 
pC.FaceAlpha = 0.6;

hold on;

[beta2,PSI2,stats2,b2] = nlmefit(x, MH, NUMS(:), [], model, beta0);

[yMH,delta] = nlpredci(model_1,x1,beta2,stats2.cwres, 'Covar',stats2.covb,...
                         'MSE',stats2.mse);
yup = yMH + delta;
ydown = yMH - delta;

xconf = [x1' x1(end:-1:1)'];         
yconf = [ydown' yup(end:-1:1)'];

pC = fill(xconf,yconf,'red');
pC.FaceColor = [0.97 0.85 0.85];      
pC.EdgeColor = 'none'; 
pC.FaceAlpha = 0.6;

p1 = plot(x1,yMW, 'Color', [0 0.66 0.52], 'LineWidth', 3);
p2 = plot(x1,yMH, 'Color', [0.9 0.38 0.38], 'LineWidth', 3);


% % CIRC = [16.5880	18.4210	17.1890;
% %         17.6390	18.0130	20.1540;
% %         17.4320	18.0220	19.6900;
% %         17.2500	17.8000	19.0260;
% %         16.2390	18.5800	18.2630;
% %         16.7550	18.3050	19.1410];
% % CIRC = [18.9110000000000,18.3760000000000,20.6320000000000;
% %     17.8090000000000,19.5880000000000,17.2810000000000;
% %     18.5790000000000,19.1210000000000,17.5550000000000;
% %     17.6550000000000,19.2330000000000,17.3110000000000;
% %     18.0100000000000,18.4420000000000,17.8470000000000;
% %     18.0070000000000,19.0460000000000,17.6800000000000];
% CIRC = [18.9110000000000,18.3760000000000,20.6320000000000;
%     17.8090000000000,19.5880000000000,17.2810000000000;
%     18.5790000000000,19.1210000000000,17.5550000000000];
% % CIRC = [95.2720000000000,92.7400000000000,88.9270000000000;
% %     85.1790000000000,90.2100000000000,90.3730000000000];
% time = [21 35 49];
% 
% h = plot(time,CIRC','o','LineWidth',2);
% xlabel('Time (days)')
% ylabel('Circumference (mm)')
% title('{\bf Orange Tree Growth}')
% legend([repmat('Tree ',3,1),num2str((1:3)')],...
%        'Location','NW')
% grid on
% hold on
% % Y = p1*x^2+p2*x+p3
% % model = @(PHI,t)(PHI(:,1))./(1+exp(-(t-PHI(:,2))./PHI(:,3)));
% model = @(PHI, t) PHI(:, 1).*t.^2 + PHI(:, 2).*t + PHI(:, 3);
% 
% TIME = repmat(time,3,1);
% NUMS = repmat((1:3)',size(time));
% 
% beta0 = [1 1 20];
% [beta1,PSI1,stats1] = nlmefit(TIME(:),CIRC(:),NUMS(:),...
%                               [],model,beta0)
%                           
% [beta2,PSI2,stats2,b2] = nlmefit(TIME(:),CIRC(:),...
%     NUMS(:),[],model,beta0,'REParamsSelect',[1 2]);
% 
% tplot = 21:1:49;
% 
% model_1 = @(PHI, t) PHI(1, 1).*t.^2 + PHI(2, 1).*t + PHI(3, 1);
% [ypred,delta] = nlpredci(model_1,tplot,beta2,stats2.cwres, 'Covar',stats2.covb,...
%                          'MSE',stats2.mse);
% 
% PHI = repmat(beta2,1,3) + ...          % Fixed effects
%       [b2(1,:);zeros(1,3);b2(2,:)];    % Random effects
% 
% y_up = ypred + delta;
% y_down = ypred - delta;
% for I = 1:1
% %   fitted_model=@(t)(PHI(1,I))./(1+exp(-(t-PHI(2,I))./ ... 
% %        PHI(3,I)));
%     fitted_model = @(t) PHI(1, I).*t.^2 + PHI(2, I).*t + PHI(3, I);
%     plot(tplot,fitted_model(tplot),'Color',h(I).Color, ...
% 	   'LineWidth',2)
%    plot(tplot, ypred);
%    plot(tplot, y_up, 'k:');
%    plot(tplot, y_down, 'k:');
% end
% hold off;
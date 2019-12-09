clear;
close all;

% CIRC = [16.5880	18.4210	17.1890;
%         17.6390	18.0130	20.1540;
%         17.4320	18.0220	19.6900;
%         17.2500	17.8000	19.0260;
%         16.2390	18.5800	18.2630;
%         16.7550	18.3050	19.1410];
CIRC = [18.9110000000000,18.3760000000000,20.6320000000000;
    17.8090000000000,19.5880000000000,17.2810000000000;
    18.5790000000000,19.1210000000000,17.5550000000000;
    17.6550000000000,19.2330000000000,17.3110000000000;
    18.0100000000000,18.4420000000000,17.8470000000000;
    18.0070000000000,19.0460000000000,17.6800000000000];
% CIRC = [95.2720000000000,92.7400000000000,88.9270000000000;
%     85.1790000000000,90.2100000000000,90.3730000000000];
time = [21 35 49];

h = plot(time,CIRC','o','LineWidth',2);
xlabel('Time (days)')
ylabel('Circumference (mm)')
title('{\bf Orange Tree Growth}')
legend([repmat('Tree ',6,1),num2str((1:6)')],...
       'Location','NW')
grid on
hold on
% Y = p1*x^2+p2*x+p3
% model = @(PHI,t)(PHI(:,1))./(1+exp(-(t-PHI(:,2))./PHI(:,3)));
model = @(PHI, t) PHI(:, 1).*t.^3 + PHI(:, 2).*t.^2 + PHI(:, 3).*t + PHI(:, 4);

TIME = repmat(time,6,1);
NUMS = repmat((1:6)',size(time));

beta0 = [1 1 1 1];
[beta1,PSI1,stats1] = nlmefit(TIME(:),CIRC(:),NUMS(:),...
                              [],model,beta0)
                          
[beta2,PSI2,stats2,b2] = nlmefit(TIME(:),CIRC(:),...
    NUMS(:),[],model,beta0,'REParamsSelect',[1 2]);

PHI = repmat(beta2,1,6) + ...          % Fixed effects
      [b2(1,:);zeros(1,6);b2(2,:)];    % Random effects

tplot = 21:1:49;
for I = 1:6
%   fitted_model=@(t)(PHI(1,I))./(1+exp(-(t-PHI(2,I))./ ... 
%        PHI(3,I)));
    fitted_model = @(t) PHI(1, I).*t.^3 + PHI(2, I).*t.^2 + PHI(3, I).*t + PHI(4, I);
    plot(tplot,fitted_model(tplot),'Color',h(I).Color, ...
	   'LineWidth',2)
end
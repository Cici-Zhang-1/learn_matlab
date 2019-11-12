clear;
close all;
% x = [21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49]';
% y = [18.16 18.17 18.18 18.19 18.19 18.19 18.19 18.19 18.19 18.19 ...
%     18.22 18.22 18.22 18.22 18.29 18.23 18.23 18.23 18.20 18.20 18.20 18.20...
%      18.15 18.15 18.15 18.15 18.08 18.08 18.05]';
%  
% xxx = [21 28 35 42 49];
% yyy = [18.16 18.25 18.29 18.20 18.05];

xTest = [21 28 35 42 49];
yTest = [16.98 17.5 18.19 18.5 18.91];

figure;

plot(xTest, yTest, 'ko');
xlabel('Time');
ylabel('Volumn(mm)');
xlim([20 50]);
ylim([16 20]);
modelFun = @(b, x) b(1) + b(2).*x + b(3).*x.^2;
start = [-0.004; 0.2664; 13.0163];
[beta, R, J, CovB, MSE, EMI] = nlinfit(xTest, yTest, modelFun, start);
xx = linspace(21,49)';
[ypred,delta] = nlpredci(modelFun,xx,beta,R,'Jacobian',J);
hold on
plot(xx,ypred,'linestyle','--','color','b');
hold off
ylower = ypred - delta;
yupper = ypred + delta;
% hold on;
% plot(xx,[ylower yupper],'r--','LineWidth',1.5)
% hold off;

xconf = [xx' xx(end:-1:1)'] ;         
yconf = [ylower' yupper(end:-1:1)'];

hold on
pC = fill(xconf,yconf,'red');
pC.FaceColor = [1 0.8 0.8];      
pC.EdgeColor = 'none'; 
hold off

% 
% y2 = [16.98 17.81 17.19]';

% plot(x, y, 'ko', xxx, yyy, 'k+');
% xlabel('Time');
% ylabel('Volumn(mm)');
% xlim([20 50]);
% ylim([16 20]);
% 
% w = [1 1 1]';
% % modelFun = @(b,x) b(1).*(1-exp(b(2).*x));
% % modelFun = @(b, x) b(1) - b(2)./x;
% % modelFun = @(b,x) b(1)-exp(b(2).*x);
% modelFun = @(b, x) b(1) + b(2).*x + b(3).*x.^2;
% start = [-0.004; 0.2664; 13.0163];
% 
% [beta, R, J, CovB, MSE, EMI] = nlinfit(x, y, modelFun, start);
% xx = linspace(21,49)';
% [ypred,delta] = nlpredci(modelFun,xx,beta,R,'Jacobian',J);
% line(xx,ypred,'linestyle','--','color','k');
% 
% [beta, R, J, CovB, MSE, EMI] = nlinfit(xxx, yyy, modelFun, start);
% [ypred,delta] = nlpredci(modelFun,xx,beta,R,'Jacobian',J);
% ylower = ypred - delta;
% yupper = ypred + delta;
% line(xx,ypred,'linestyle','-','color','k');
% hold on;
% plot(xx,[ylower yupper],'r--','LineWidth',1.5)
% hold off;


% nlm = fitnlm(x,y,modelFun,start);
% xx = linspace(21,49)';
% line(xx,predict(nlm,xx),'linestyle','--','color','k')
% 
% nlm2 = fitnlm(x, y2, modelFun, start);
% line(xx, predict(nlm2, xx), 'linestyle', '-');
% 
% p = polyfit(x, y2, 2);
% y_ = polyval(p, xx);
% line(xx, y_);


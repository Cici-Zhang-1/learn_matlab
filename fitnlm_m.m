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



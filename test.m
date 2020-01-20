im = imread('cameraman.tif');
imagesc(im);
axis image off; 
colormap gray;
title('Please Draw ROI');
% Draw ROI
[binaryMask, x, y] = roipoly;
hold on;
plot(x, y, 'r.-', 'MarkerSize', 15);

% Demo to have the user freehand draw an irregular shape over
% a gray scale image, have it convert that portion to a
% color RGB image defined by a colormap.
clc;  % Clear command window.
workspace;  % Make sure the workspace panel is showing.
fontSize = 16;
% Read in a standard MATLAB gray scale demo image.
folder = fullfile(matlabroot, '\toolbox\images\imdemos');
baseFileName = 'cameraman.tif';
% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
% Check if file exists.
if ~exist(fullFileName, 'file')
  % File doesn't exist -- didn't find it there.  Check the search path for it.
  fullFileName = baseFileName; % No path this time.
  if ~exist(fullFileName, 'file')
    % Still didn't find it.  Alert user.
    errorMessage = sprintf('Error: %s does not exist in the search path folders.', fullFileName);
    uiwait(warndlg(errorMessage));
    return;
  end
end
grayImage = imread(fullFileName);
imshow(grayImage, []);
axis on;
title('Original Grayscale Image', 'FontSize', fontSize);
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
message = sprintf('Left click and hold to begin drawing.\nSimply lift the mouse button to finish');
uiwait(msgbox(message));
hFH = imfreehand();
% Create a binary image ("mask") from the ROI object.
binaryImage = hFH.createMask();
xy = hFH.getPosition;
% Now make it smaller so we can show more images.
subplot(2, 2, 1);
imshow(grayImage, []);
axis on;
drawnow;
title('Original Grayscale Image', 'FontSize', fontSize);
% Display the freehand mask.
subplot(2, 2, 2);
imshow(binaryImage);
axis on;
title('Binary mask of the region', 'FontSize', fontSize);
% Convert the grayscale image to RGB using the jet colormap.
rgbImage = ind2rgb(grayImage, jet(256));
% Scale and convert from double (in the 0-1 range) to uint8.
rgbImage = uint8(255*rgbImage);
% Display the RGB image.
subplot(2, 2, 3);
imshow(rgbImage);
axis on;
title('RGB Image from Jet Colormap', 'FontSize', fontSize);
% Extract the red, green, and blue channels from the color image.
redChannel = rgbImage(:, :, 1);
greenChannel = rgbImage(:, :, 2);
blueChannel = rgbImage(:, :, 3);
% Create a new color channel images for the output.
outputImageR = grayImage;
outputImageG = grayImage;
outputImageB = grayImage;
% Transfer the colored parts.
outputImageR(binaryImage) = redChannel(binaryImage);
outputImageG(binaryImage) = greenChannel(binaryImage);
outputImageB(binaryImage) = blueChannel(binaryImage);
% Convert into an RGB image
outputRGBImage = cat(3, outputImageR, outputImageG, outputImageB);
% Display the output RGB image.
subplot(2, 2, 4);
imshow(outputRGBImage);
axis on;
title('Output RGB Image', 'FontSize', fontSize);
% 12/13/2019
% CIRC = [30 58 87 115 120 142 145;
%         33 69 111 156 172 203 203;
%         30 51 75 108 115 139 140;
%         32 62 112 167 179 209 214;
%         30 49 81 125 142 174 177];
% time = [118 484 664 1004 1231 1372 1582];
% 
% h = plot(time,CIRC','o','LineWidth',2);
% xlabel('Time (days)')
% ylabel('Circumference (mm)')
% title('{\bf Orange Tree Growth}')
% legend([repmat('Tree ',5,1),num2str((1:5)')],...
%        'Location','NW')
% grid on
% hold on
% model = @(PHI,t)(PHI(:,1))./(1+exp(-(t-PHI(:,2))./PHI(:,3)));
% TIME = repmat(time,5,1);
% NUMS = repmat((1:5)',size(time));
% 
% beta0 = [100 100 100];
% [beta1,PSI1,stats1] = nlmefit(TIME(:),CIRC(:),NUMS(:),...
%                               [],model,beta0)
% [beta2,PSI2,stats2,b2] = nlmefit(TIME(:),CIRC(:),...
%     NUMS(:),[],model,beta0,'REParamsSelect',[1 2 3])
% PHI = repmat(beta2,1,5) + ...          % Fixed effects
%       [b2(1,:);zeros(1,5);b2(2,:)];    % Random effects
% 
% tplot = 0:0.1:1600;
% for I = 1:5
%   fitted_model=@(t)(PHI(1,I))./(1+exp(-(t-PHI(2,I))./ ... 
%        PHI(3,I)));
%   plot(tplot,fitted_model(tplot),'Color',h(I).Color, ...
% 	   'LineWidth',2)
% end
% load fisheriris;
% t = table(species,meas(:,1),meas(:,2),meas(:,3),meas(:,4),...
% 'VariableNames',{'species','meas1','meas2','meas3','meas4'});
% Meas = table([1 2 3 4]','VariableNames',{'Measurements'});
% rm = fitrm(t,'meas1-meas4~species','WithinDesign',Meas);
% manova(rm)
% clear;
% close all;
% 
% %calculate repeated measure anova
% 
% if ispc
%     folder = 'F:\T2-1\Analysis\';
% elseif ismac
%     folder = '/Users/chuangchuangzhang/Downloads/Analysis/';
% elseif isunix
% else
% end
% 
% filename = ['ZQ175-3W-';'ZQ175-5W-';'ZQ175-7W-'];
% no = '2';
% MW_Combine = [];
% MH_Combine = [];
% Combine = [];
% % Brain CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule
% type = 'CaudatePutamen';
% for i = 1:size(filename, 1)
%     MW_Combine = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MW_Combine');
%     MH_Combine = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MH_Combine');
%     Combine(1:size(MW_Combine, 2), i) = MW_Combine{type, :};
%     Combine(size(MW_Combine, 2) + 1: size(MW_Combine, 2) + size(MH_Combine, 2), i) = MH_Combine{type, :};
% end
% 
% Model = {'MWT' 'MWT' 'MWT' 'MWT' 'MWT' 'MWT' 'MHD' 'MHD' 'MHD' 'MHD' 'MHD' 'MHD'}';
% 
% Time = [21 35 49]';
% 
% t = table(Model, Combine(:,1), Combine(:,2), Combine(:,3), ...
% 'VariableNames',{'Model','P21','P35','P49'});
% 
% rm = fitrm(t,'P21-P49 ~ Model','WithinDesign',Time, 'WithinModel', 'orthogonalcontrasts');
% 
% time = linspace(21, 49)';
% [Y, ypredci] = predict(rm,t([3 11],:), ...
%     'WithinModel','orthogonalcontrasts','WithinDesign',time, 'alpha', 0.05);
% % p1 = plotprofile(rm,'Time','Group',{'Model'});
% p1 = plot(time, Y(1, :), 'Color', [0 0.66 0.52], 'LineWidth', 3);
% hold on; 
% p2 = plot(time, Y(2, :), 'Color', [0.9 0.38 0.38], 'LineWidth', 3);
% % p3 = plot(time,ypredci(1,:,1),'k--');
% % p4 = plot(time,ypredci(1,:,2),'k--');
% % p5 = plot(time, ypredci(2, :, 1), 'k-.');
% % p6 = plot(time, ypredci(2, :, 2), 'k-.');
% % legend([p1;p2(1);p3(1)],'Gender=F','Gender=M','Predictions','Confidence Intervals')
% xconf = [time' time(end:-1:1)'];
% yconf = [ypredci(1,:,1) ypredci(1, end:-1:1, 2)];
% 
% pC = fill(xconf,yconf,'green');
% pC.FaceColor = [0.77 0.9 0.875];      
% pC.EdgeColor = 'none'; 
% pC.FaceAlpha = 0.6;
% 
% yconf = [ypredci(2,:,1) ypredci(2, end:-1:1, 2)];
% 
% pC = fill(xconf,yconf,'red');
% pC.FaceColor = [0.97 0.85 0.85];      
% pC.EdgeColor = 'none'; 
% pC.FaceAlpha = 0.6;
% 
% xlim([20 50]);
% xticks([21 35 49]);
% if strcmp(type, 'CaudatePutamen')
% %     ylim([14 22]);
%     ylim([16 21]);
% elseif strcmp(type, 'Neocortex')
% %     ylim([70 110])
%     ylim([75 100]);
% elseif strcmp(type, 'Cerebellum')
% %     ylim([30 70]);
%     ylim([40 60]);
% elseif strcmp(type, 'Thalamus')
% %     ylim([15 28]);
%     ylim([18 24]);
% elseif strcmp(type, 'PeriformCortex')
%     ylim([1 5]);
% elseif strcmp(type, 'Hypothalamus')
%     ylim([6 16]);
% elseif strcmp(type, 'CC/ExternalCapsule')
%     ylim([8 16]);
% elseif strcmp(type, 'Brain')
%     ylim([350 500]);
% else
% end
% % ylim([15 25]);
% xlabel('Days', 'FontSize', 18);
% ylabel('Volumn(mm^3)', 'FontSize', 18);
% 
% ax = gca; % current axes
% ax.FontSize = 16;
% 
% lgd = legend([p1 p2],{'WT', 'HD'}, 'Location', 'northwest', 'FontSize', 12);
% legend('boxoff');
% title(lgd, ['Male ' type]);
% hold off


% clear;
% close all;
% load longitudinalData;
% Gender = ['F' 'F' 'F' 'F' 'F' 'F' 'F' 'F' 'M' 'M' 'M' 'M' 'M' 'M' 'M' 'M']';
% t = table(Gender,Y(:,1),Y(:,2),Y(:,3),Y(:,4),Y(:,5), ...
%     'VariableNames',{'Gender','t0','t2','t4','t6','t8'});
% Time = [0 2 4 6 8]';
% rm = fitrm(t,'t0-t8 ~ Gender','WithinDesign',Time);
% time = linspace(0,8)';
% Y = predict(rm,t(:,:), ...
%     'WithinModel','orthogonalcontrasts','WithinDesign',time);
% plotprofile(rm,'Time','Group',{'Gender'})
% hold on; 
% plot(time,Y,'Color','k','LineStyle',':');
% legend('Gender=F','Gender=M','Predictions')
% hold off

% 12062019
% clear;
% close all;
% if ispc
%     folder = 'F:\T2-1\Analysis\';
% elseif ismac
%     folder = '/Users/chuangchuangzhang/Downloads/Analysis/';
% elseif isunix
% else
% end
% 
% filename = ['ZQ175-3W-';'ZQ175-5W-';'ZQ175-7W-'];
% no = '2';
% MW_Combine = [];
% MH_Combine = [];
% Combine = [];
% % Brain CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule
% type = 'Brain';
% starts = 1;
% ends = 0;
% for i = 1:size(filename, 1)
%     MW_Combine = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MW');
%     MH_Combine = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MH');
%     ends = ends + size(MW_Combine, 2);
%     Combine(starts : ends, 1) = MW_Combine{type, :};
%     starts = ends + 1;
%     ends = ends + size(MW_Combine, 2);
%     Combine(starts : ends, 1) = MH_Combine{type, :};
%     starts = ends + 1;
% end
% 
% S = [linspace(1, 12, 12) linspace(1, 12, 12) linspace(1, 12, 12)]';
% F1 = [ones(1, 12)*21 ones(1, 12)*35 ones(1, 12)*49]';
% F2_1 = [ones(1, 6) ones(1, 6)*2]';
% F2 = [F2_1; F2_1; F2_1];
% 
% stats = rm_anova2(Combine, S, F1, F2, {'Time', 'Model'});

% 12/03/2019
% clear;
% close all;
% 
% %calculate repeated measure anova
% 
% if ispc
%     folder = 'F:\T2-1\Analysis\';
% elseif ismac
%     folder = '/Users/chuangchuangzhang/Downloads/Analysis/';
% elseif isunix
% else
% end
% 
% filename = ['ZQ175-3W-';'ZQ175-5W-';'ZQ175-7W-'];
% no = '2';
% MW_Combine = [];
% MH_Combine = [];
% W_Combine = [];
% H_Combine = [];
% % Brain CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule
% type = 'Brain';
% for i = 1:size(filename, 1)
%     MW_Combine = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MW');
%     MH_Combine = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MH');
%     W_Combine(1:size(MW_Combine, 2), i) = MW_Combine{type, :};
%     H_Combine(1:size(MW_Combine, 2), i) = MH_Combine{type, :};
% end
% 
% [ps, tables] = anova_rm({W_Combine H_Combine}, 'on');
% % Model = {'MWT' 'MWT' 'MWT' 'MWT' 'MWT' 'MWT' 'MHD' 'MHD' 'MHD' 'MHD' 'MHD' 'MHD'}';
% % 
% % Time = [21 35 49]';
% % 
% % t = table(Model, Combine(:,1), Combine(:,2), Combine(:,3), ...
% % 'VariableNames',{'Model','P21','P35','P49'});
% % 
% % rm = fitrm(t,'P21-P49 ~ Model','WithinDesign',Time);
% % ranovatbl = ranova(rm);
% % 12/03/2019
% clear;
% close all;
% Y = [11, 12, 13, 11, 15, 12, 13, 14, 12]';
% S = [1, 1, 1, 1, 1, 1, 1, 1, 1]';
% F1 = [1, 2, 3, 1, 2, 3, 1, 2, 3]';
% F2 = [1, 1, 1, 2, 2, 2, 3, 3, 3]';
% FACTNAMES = {'Days', 'Type'};
% stats = rm_anova2(Y,S,F1,F2,FACTNAMES);
% % 12/03/2019
% clear;
% close all;
% 
% folder = '/Users/chuangchuangzhang/Downloads/Analysis/';
% filename = ['ZQ175-3W-';'ZQ175-5W-';'ZQ175-7W-'];
% no = '2';
% MH_Part = [];
% % CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule
% type = 'CaudatePutamen';
% for i = 1:size(filename, 1)
%     Mean = readtable([folder filename(i, :) no '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'Mean');
%     MH_Part(i, 1) = Mean{type, 'MH'};
%     MW_Part(1, i) = Mean{type, 'MW'};
% end
% 
% x = [21, 35, 49]';
% x1 = linspace(21,49);
% % 
% % xi = (0:.05:1);
% % q = @(x) x.^3;
% % yi = q(xi);
% % randomStream = RandStream.create( 'mcg16807', 'Seed', 23 );
% % ybad = yi+.3*(rand(randomStream, size(xi))-.5);
% % p = 0.1;
% 
% % ys = csaps(x, MH_Part,p,x1);
% % plot(x, MH_Part, 'x', x1, ys, 'r-')
% % yMW = csaps(x, MW_Part, p, x1);
% % hold on
% % plot(x, MW_Part, 'x', x1, yMW, 'g-');
% % hold off
% 
% f = fit(x,MH_Part,'poly2');
% plot(f,x,MH_Part);
% title('Clean Data, Noisy Data, Smoothed Values')
% legend( 'Noisy', 'Smoothed', 'Location', 'NorthWest' )
% 11/25/2019
% % close all;
% % clear;
% % load mri;
% % M1 = D(:, 64, :, :);
% % M2 = reshape(M1, [128, 27]);
% % % figure;
% % % imshow(M2, map);
% % % title('Sage');
% % T0 = maketform('affine', [0 -2.5; 1 0; 0 0]);
% % R2 = makeresampler({'cubic', 'nearest'}, 'fill');
% % M3 = imtransform(M2, T0, R2);
% % figure;
% % imshow(M3, map);
% % title('Sagi-IM');
% % plot3()
% clc;    % Clear the command window.
% close all;  % Close all figures (except those of imtool.)
% clear;  % Erase all existing variables. Or clearvars if you want.
% workspace;  % Make sure the workspace panel is showing.
% format long g;
% format compact;
% fontSize = 20;
% % Read in mat file.
% % storedStructure = load('binaryimage.mat');
% % binaryImage = storedStructure.BWfinal;
% I = imread('vessel.jpeg');
% binaryImage = imbinarize(I(:, :, 3));
% % Display the image.
% subplot(2, 2, 1);
% imshow(binaryImage, []);
% title('Original Binary Image', 'FontSize', fontSize, 'Interpreter', 'None');
% % Set up figure properties:
% % Enlarge figure to full screen.
% set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% % Get rid of tool bar and pulldown menus that are along top of figure.
% set(gcf, 'Toolbar', 'none', 'Menu', 'none');
% % Give a name to the title bar.
% set(gcf, 'Name', 'Demo by ImageAnalyst', 'NumberTitle', 'Off') 
% drawnow;
% % Fill the image.
% binaryImage(1,:) = true;
% binaryImage(end,:) = true;
% binaryImage = imfill(binaryImage, 'holes');
% % Display the image.
% subplot(2, 2, 2);
% imshow(binaryImage, []);
% title('Original Binary Image', 'FontSize', fontSize, 'Interpreter', 'None');
% drawnow;
% % Get the Euclidean Distance Transform.
% binaryImage(1,:) = false;
% binaryImage(end,:) = false;
% edtImage = bwdist(~binaryImage);
% % Display the image.
% subplot(2, 2, 3);
% imshow(edtImage, []);
% title('Distance Transform Image', 'FontSize', fontSize, 'Interpreter', 'None');
% drawnow;
% skelImage = bwmorph(binaryImage, 'skel', inf);
% skelImage = bwmorph(skelImage, 'spur', 40);
% % There should be just one now.  Let's check
% [labeledImage, numLines] = bwlabel(skelImage);
% fprintf('Found %d lines\n', numLines);
% % Display the image.
% subplot(2, 2, 4);
% imshow(skelImage, []);
% title('Skeleton Image', 'FontSize', fontSize, 'Interpreter', 'None');
% % Measure the radius be looking along the skeleton of the distance transform.
% meanRadius = mean(edtImage(skelImage))
% meanDiameter = 2 * meanRadius
% message = sprintf('Mean Radius = %.1f pixels.\nMean Diameter = %.1f pixels',...
%   meanRadius, meanDiameter);
% uiwait(helpdlg(message));

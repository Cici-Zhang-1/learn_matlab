clear
close all;

addpath('.\NIfTI');
addpath('.\func');
floder = 'F:\T2-1\ZQ175-3W-1\163\';
num = '';

nii = load_nii([floder num '163updated.img']);
toshow = nii.img;

intensity = [0 20 40 120 220 1024];
alpha = [0 0 0.15 0.3 0.38 0.5];
color = ([0 0 0; 43 0 0; 103 37 20; 199 155 97; 216 213 201; 255 255 255]) ./ 255;
queryPoints = linspace(min(intensity),max(intensity),256);
alphamap = interp1(intensity,alpha,queryPoints)';
colormap = interp1(intensity,color,queryPoints);
vol = volshow(toshow,'Colormap',colormap,'Alphamap',alphamap);
close all;
clear;
load mri;
M1 = D(:, 64, :, :);
M2 = reshape(M1, [128, 27]);
% figure;
% imshow(M2, map);
% title('Sage');
T0 = maketform('affine', [0 -2.5; 1 0; 0 0]);
R2 = makeresampler({'cubic', 'nearest'}, 'fill');
M3 = imtransform(M2, T0, R2);
figure;
imshow(M3, map);
title('Sagi-IM');
plot3()
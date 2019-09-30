clear;
close all;

% addpath('./vis3d');
addpath('./NIfTI');
addpath('./func');
floder = '/Users/chuangchuangzhang/Downloads/OneDrive_1_2019-9-4/183/';
% v = niftiread('172w3.hdr', '172w3.img');
% 
% imshow(v(:, :, 128));

% info = niftiinfo('172w3.hdr');

% vis3d('172w3.img')

nii = load_nii([floder '183Skull.img']);
% nii = load_nii('./updated.img');
global showHistory
global minHistory
global maxHistory
global currentHistory
global old_toshow % original image
global toshow % change the original image to the direction we want to see
global prev_next
global currentPixelX
global currentPixelY
global currentPixel
currentPixelX = 0;
currentPixelY = 0;
currentPixel = 0;
old_toshow = nii.img;
firstD = size(old_toshow, 1);
secondD = size(old_toshow, 2);
thirdD = size(old_toshow, 3);
middleSlice = secondD/2;
toshow = zeros(firstD, thirdD, secondD);
showHistory = zeros(firstD, thirdD, secondD, 10);
minHistory = 1;
maxHistory = 1;
currentHistory = 1;
for i = 1:secondD
    toshow(:, :, i) = shape_matrix(old_toshow, i);
end
showHistory(:, :, :, 1) = toshow; 
prev_next = 0;
f = figure;
% toshowSlice = shape_matrix(toshow, 90);
imgobj = imshow(toshow(:, :, middleSlice),[0 max(max(toshow(:, :, middleSlice)))*.9]);

set(gcf, 'position', [500, 100, 900, 900]);
% current slice number
current_slice = uicontrol('Parent', f, 'Style', 'text', 'Position', [430, 160, 40, 20], ...
                'String', '90');
% slice number
s = uicontrol('Parent',f,'Style','slider','Position',[80,180,740,23],...
              'value',middleSlice, 'min',1, 'max',secondD, 'SliderStep', [0.0056 0.0056]);
s.Callback = @(es,ed) show_next_prev(es.Value, s, imgobj, current_slice);

% Previous or Next ROI dispose          
c_prev_next = uicontrol('Parent', f, 'Style', 'checkbox', 'Position', [80, 140, 60, 30], ...
          'value', 0, 'string', {'PN'});
% dispose how many slice
e_slice = uicontrol('Parent', f, 'Style','edit', 'Position', [140, 140, 50, 30], 'String', '0');
% if optimize roi
c_roi_optimize = uicontrol('Parent', f, 'Style', 'checkbox', 'Position', [190, 140, 60, 30], ...
          'value', 0, 'string', {'Opt'});
% ROI Button
b = uicontrol('Parent',f,'Style','pushbutton','Position',[250,140,30,30],...
              'value',0, 'min',0, 'max',1, 'String', 'ROI');
          b.Callback = @(src, event) display_roi(s.Value, imgobj, ...
              str2num(e_slice.String), c_prev_next.Value, c_roi_optimize.Value,secondD, 1);
b_drawassisted = uicontrol('Parent',f,'Style','pushbutton','Position',[400,140,30,30],...
            'value',0, 'min',0, 'max',1, 'String', 'A');
        b_drawassisted.Callback = @(src, event) display_roi(s.Value, imgobj, ...
                str2num(e_slice.String), c_prev_next.Value, c_roi_optimize.Value,secondD, 2);
b_drawcircie = uicontrol('Parent',f,'Style','pushbutton','Position',[430,140,30,30],...
            'value',0, 'min',0, 'max',1, 'String', 'C');
        b_drawcircie.Callback = @(src, event) display_roi(s.Value, imgobj, ...
                str2num(e_slice.String), c_prev_next.Value, c_roi_optimize.Value,secondD, 3);
b_drawellipse = uicontrol('Parent',f,'Style','pushbutton','Position',[460,140,30,30],...
            'value',0, 'min',0, 'max',1, 'String', 'E');
        b_drawellipse.Callback = @(src, event) display_roi(s.Value, imgobj, ...
                str2num(e_slice.String), c_prev_next.Value, c_roi_optimize.Value,secondD, 4);

% Pixel Value                   
e = uicontrol('Parent', f, 'Style','edit', 'Position', [310, 140, 60, 30]);
% Min Pixel Value                   
e_min_piexl = uicontrol('Parent', f, 'Style','edit', 'Position', [490, 140, 60, 30], 'String', 0);
% Get Pixels
b_pixel = uicontrol('Parent', f, 'Style', 'pushbutton', 'Position', [280, 140, 30, 30], ...
              'value', 0, 'min', 0, 'max', 1);
          b_pixel.String = 'Pixel';
          b_pixel.Callback = @(src, event) change_pixel(imgobj, e);
% Clear Based on Pixels
b_auto_pixel = uicontrol('Parent', f, 'Style', 'pushbutton', 'Position', [370, 140, 30, 30], ...
              'value', 0, 'min', 0, 'max', 1);
          b_auto_pixel.String = 'AP';
          b_auto_pixel.Callback = @(src, event) auto_pixel(s, imgobj, e, e_min_piexl, secondD, c_prev_next.Value);
          
b_morph = uicontrol('Parent', f, 'Style', 'pushbutton', 'Position', [550, 140, 30, 30], ...
                'value', 0, 'min', 0, 'max', 1, 'String', 'M');
            b_morph.Callback = @(s, e) do_morph(imgobj, s.Value);
% Display Previous Image          
b_display_previous = uicontrol('Parent', f, 'Style', 'pushbutton', 'Position', [80, 110, 120, 30], ...
              'value', 0, 'min', 0, 'max', 1, 'String', 'Previous');
          b_display_previous.Callback = @(src, event) display_previous(imgobj, s.Value);
% Display Next Image
b_display_next = uicontrol('Parent', f, 'Style', 'pushbutton', 'Position', [200, 110, 120, 30], ...
              'value', 0, 'String', 'Next');
          b_display_next.Callback = @(src, event) display_next(imgobj, s.Value);
% Save Image Button          
b_save_nii = uicontrol('Parent', f, 'Style', 'pushbutton', 'Position', [320, 110, 30, 30], ...
              'value', 0, 'min', 0, 'max', 1);
          b_save_nii.String = 'Save';
          b_save_nii.Callback = @(src, event) display_save_nii(nii, [floder 'updated'], firstD, secondD, thirdD);

          
% function display_save_nii(nii)
%     global old_toshow
%     global toshow
%     for i = 1:size(old_toshow, 2)
%         tmp = toshow(:, :, i);
%         old_toshow(:, i, :) = reshape(tmp, [256, 1, 256]);
%     end
%     nii.img = old_toshow;
%     save_nii(nii, 'updated');
%     return
% end
%           
% function display_roi(s, img)
%     global toshow
%     global prev_next
%     BW = roipoly;
%     tmp = img.CData;
%     for i = 1:size(BW, 1)
%         for j = 1:size(BW, 2)
%             if BW(i, j) == 1
%                 tmp(i, j) = 0;
%             end
%         end
%     end
%     toshow(:, :, s.Value) = tmp;
%     next = s.Value + 1;
%     pre = s.Value - 1;
%     flag = 1;
%     while next <= 180  && flag && prev_next
%         flag = 0;
%         for i = 1:size(BW, 1)
%             for j = 1:size(BW, 2)
%                 if BW(i, j) == 1
%                     if (toshow(i, j, next) > 0) 
%                         toshow(i, j, next) = 0;
%                         flag = 1;
%                     end
%                 end
%             end
%         end
%         next = next + 1;
%     end
%     flag = 1;
%     while pre >= 0 && flag && ~prev_next
%         flag = 0;
%         for i = 1:size(BW, 1)
%             for j = 1:size(BW, 2)
%                 if BW(i, j) == 1
%                     if (toshow(i, j, pre) > 0) 
%                         toshow(i, j, pre) = 0;
%                         flag = 1;
%                     end
%                 end
%             end
%         end
%         pre = pre - 1;
%     end
%     display_refresh(img, tmp);
%     return
% end
% 
% function display_refresh(img, refresh_data) 
%     set(img, 'CData', refresh_data);
%     return
% end
% function a = show_next_prev(slice, s, img)
%     global toshow
%     slice = round(slice);
%     s.Value = round(slice);
%     disp(slice);
%     a = slice;
%     set(img, 'CData', toshow(:, :, slice));
%     return
% end

% function change_pixel(img)
%     global currentPixelX
%     global currentPixelY
%     global currentPixel
%     [currentPixelX, currentPixelY] = ginput(1);
%     currentPixelX = round(currentPixelX);
%     currentPixelY = round(currentPixelY);
%     disp(currentPixelX);
%     disp(currentPixelY);
%     currentPixel = img.CData(currentPixelY, currentPixelX);
%     disp(currentPixel);
%     return
% end

% function auto_pixel(s, img, e, maxSlice, prev_next)
%     global toshow
%     global currentPixel
% %     e.String = str2num(e.String);
%     if isempty(e.String)
%         e.String = currentPixel;
%     else
%         currentPixel = str2num(e.String);
%     end
%     disp(currentPixel);
%     BW = roipoly;
%     tmp = img.CData;
%     for i = 1:size(BW, 1)
%         for j = 1:size(BW, 2)
%             if BW(i, j) == 1 && tmp(i, j) <= currentPixel
%                 tmp(i, j) = 0;
%             end
%         end
%     end
%     toshow(:, :, s.Value) = tmp;
%     next = s.Value + 1;
%     pre = s.Value - 1;
%     flag = 1;
%     while next <= maxSlice  && flag && prev_next
%         flag = 0;
%         for i = 1:size(BW, 1)
%             for j = 1:size(BW, 2)
%                 if BW(i, j) == 1
%                     if (toshow(i, j, next) > 0 && toshow(i, j, next) <= currentPixel) 
%                         toshow(i, j, next) = 0;
%                         flag = 1;
%                     end
%                 end
%             end
%         end
%         next = next + 1;
%     end
%     flag = 1;
%     while pre > 0 && flag && ~prev_next
%         flag = 0;
%         for i = 1:size(BW, 1)
%             for j = 1:size(BW, 2)
%                 if BW(i, j) == 1
%                     if (toshow(i, j, pre) > 0 && toshow(i, j, pre) <= currentPixel) 
%                         toshow(i, j, pre) = 0;
%                         flag = 1;
%                     end
%                 end
%             end
%         end
%         pre = pre - 1;
%     end
%     display_refresh(img, tmp);
%     return
% end
% 
% BW = roipoly;
% for i = 1:size(BW, 1)
%     for j = 1:size(BW, 2)
%         if BW(i, j) == 1
%             toshow(i, j, 128) = 0;
%         end
%     end
% end
% imshow(toshow(:,:,128)',[0 max(max(toshow(:,:,128)))*.9]);
% 
% nii = load_nii('172w3.img');
% view_nii(nii);





clear;
close all;

% addpath('./vis3d');
addpath('./NIfTI');
% v = niftiread('172w3.hdr', '172w3.img');
% 
% imshow(v(:, :, 128));

% info = niftiinfo('172w3.hdr');

% vis3d('172w3.img')

nii = load_nii('./183/183Skull.img');
global old_toshow
global toshow
global prev_next
global currentPixelX
global currentPixelY
global currentPixel
currentPixelX = 0;
currentPixelY = 0;
currentPixel = 0;
old_toshow = nii.img;
toshow = zeros(size(old_toshow, 1), size(old_toshow, 3), size(old_toshow, 2));
for i = 1:size(old_toshow, 2)
    tmp = to_show_slice(old_toshow, i);
    toshow(:, :, i) = tmp;
end

prev_next = 0;
f = figure;
% toshowSlice = to_show_slice(toshow, 90);
imgobj = imshow(toshow(:, :, 90),[0 max(max(toshow(:, :, 90)))*.9]);

set(gcf, 'position', [50, 100, 500, 500]);

s = uicontrol('Parent',f,'Style','slider','Position',[81,54,350,23],...
              'value',90, 'min',1, 'max',180, 'SliderStep', [0.0056 0.0056]);
          
s.Callback = @(es,ed) show_next_prev(es.Value, s, imgobj);

b = uicontrol('Parent',f,'Style','pushbutton','Position',[81,10,30,30],...
              'value',0, 'min',0, 'max',1);
          b.String = 'ROI';
          b.Callback = @(src, event) display_roi(s, imgobj);
          
b_save_nii = uicontrol('Parent', f, 'Style', 'pushbutton', 'Position', [150, 10, 30, 30], ...
              'value', 0, 'min', 0, 'max', 1);
          b_save_nii.String = 'Save';
          b_save_nii.Callback = @(src, event) display_save_nii(nii);
          
c_prev_next = uicontrol('Parent', f, 'Style', 'checkbox', 'Position', [200, 10, 30, 30], ...
          'value', 0, 'min', 0, 'max', 1);
          c_prev_next.String = 'PN';
          c_prev_next.Callback = @(src, event) change_prev_next(src);
      
b_pixel = uicontrol('Parent', f, 'Style', 'pushbutton', 'Position', [250, 10, 30, 30], ...
              'value', 0, 'min', 0, 'max', 1);
          b_pixel.String = 'Pixel';
          b_pixel.Callback = @(src, event) change_pixel(imgobj);
          
e = uicontrol('Parent', f, 'Style','edit', 'Position', [350, 10, 60, 30]);

b_auto_pixel = uicontrol('Parent', f, 'Style', 'pushbutton', 'Position', [300, 10, 30, 30], ...
              'value', 0, 'min', 0, 'max', 1);
          b_auto_pixel.String = 'AP';
          b_auto_pixel.Callback = @(src, event) auto_pixel(s, imgobj, e);
          


          
function display_save_nii(nii)
    global old_toshow
    global toshow
    for i = 1:size(old_toshow, 2)
%         tmp = to_show_slice(old_toshow, i);
%         toshow(:, :, i) = tmp;
        tmp = toshow(:, :, i);
        old_toshow(:, i, :) = reshape(tmp, [256, 1, 256]);
    end
    nii.img = old_toshow;
    save_nii(nii, 'updated');
    return
end
          
function display_roi(s, img)
    global toshow
    global prev_next
    BW = roipoly;
    tmp = img.CData;
    for i = 1:size(BW, 1)
        for j = 1:size(BW, 2)
            if BW(i, j) == 1
                tmp(i, j) = 0;
            end
        end
    end
    toshow(:, :, s.Value) = tmp;
    next = s.Value + 1;
    pre = s.Value - 1;
    flag = 1;
    while next <= 180  && flag && prev_next
        flag = 0;
        for i = 1:size(BW, 1)
            for j = 1:size(BW, 2)
                if BW(i, j) == 1
                    if (toshow(i, j, next) > 0) 
                        toshow(i, j, next) = 0;
                        flag = 1;
                    end
                end
            end
        end
        next = next + 1;
    end
    flag = 1;
    while pre >= 0 && flag && ~prev_next
        flag = 0;
        for i = 1:size(BW, 1)
            for j = 1:size(BW, 2)
                if BW(i, j) == 1
                    if (toshow(i, j, pre) > 0) 
                        toshow(i, j, pre) = 0;
                        flag = 1;
                    end
                end
            end
        end
        pre = pre - 1;
    end
    display_refresh(img, tmp);
    return
end

function display_refresh(img, refresh_data) 
    set(img, 'CData', refresh_data);
    return
end
function a = show_next_prev(slice, s, img)
    global toshow
    slice = round(slice);
    s.Value = round(slice);
    disp(slice);
    a = slice;
    set(img, 'CData', toshow(:, :, slice));
    return
end

function slice_data = to_show_slice(toshow, slice_num)
    tmp = toshow(:,slice_num,:);
    slice_data = reshape(tmp, [256, 256]);
	return
end

function change_prev_next(e)
    global prev_next
    prev_next = e.Value;
    return
end

function change_pixel(img)
    global currentPixelX
    global currentPixelY
    global currentPixel
    [currentPixelX, currentPixelY] = ginput(1);
    currentPixelX = round(currentPixelX);
    currentPixelY = round(currentPixelY);
    disp(currentPixelX);
    disp(currentPixelY);
    currentPixel = img.CData(currentPixelX, currentPixelY);
    disp(currentPixel);
    return
end

function auto_pixel(s, img, e)
    global toshow
    global currentPixel
    global prev_next
%     e.String = str2num(e.String);
    if isempty(e.String)
        e.String = currentPixel;
    else
        currentPixel = str2num(e.String);
    end
    disp(currentPixel);
    BW = roipoly;
    tmp = img.CData;
    for i = 1:size(BW, 1)
        for j = 1:size(BW, 2)
            if BW(i, j) == 1 && tmp(i, j) <= currentPixel
                tmp(i, j) = 0;
            end
        end
    end
    toshow(:, :, s.Value) = tmp;
    next = s.Value + 1;
    pre = s.Value - 1;
    flag = 1;
    while next <= 180  && flag && prev_next
        flag = 0;
        for i = 1:size(BW, 1)
            for j = 1:size(BW, 2)
                if BW(i, j) == 1
                    if (toshow(i, j, next) > 0 && toshow(i, j, next) <= currentPixel) 
                        toshow(i, j, next) = 0;
                        flag = 1;
                    end
                end
            end
        end
        next = next + 1;
    end
    flag = 1;
    while pre >= 0 && flag && ~prev_next
        flag = 0;
        for i = 1:size(BW, 1)
            for j = 1:size(BW, 2)
                if BW(i, j) == 1
                    if (toshow(i, j, pre) > 0 && toshow(i, j, next) <= currentPixel) 
                        toshow(i, j, pre) = 0;
                        flag = 1;
                    end
                end
            end
        end
        pre = pre - 1;
    end
    display_refresh(img, tmp);
    return
end
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





function auto_pixel(s, img, e, eMinPixel, maxSlice, prev_next)
    global toshow
    global currentPixel
%     e.String = str2num(e.String);
    if isempty(e.String)
        e.String = currentPixel;
    else
        currentPixel = str2num(e.String);
    end
    if isempty(eMinPixel.String)
        eMinPixel.String = '0';
        minPixel = 0;
    else 
        minPixel = str2num(eMinPixel.String);
    end
    if currentPixel <= minPixel
        currentPixel = Inf;
    end
    BW = roipoly;
    tmp = img.CData;
    for i = 1:size(BW, 1)
        for j = 1:size(BW, 2)
            if BW(i, j) == 1 && tmp(i, j) <= currentPixel && tmp(i, j) >= minPixel
                tmp(i, j) = 0;
            end
        end
    end
    toshow(:, :, s.Value) = tmp;
    next = s.Value + 1;
    pre = s.Value - 1;
    flag = 1;
    while next <= maxSlice  && flag && prev_next
        flag = 0;
        for i = 1:size(BW, 1)
            for j = 1:size(BW, 2)
                if BW(i, j) == 1 && ...
                        (toshow(i, j, next) > 0 && toshow(i, j, next) <= currentPixel && toshow(i, j, next) >= minPixel) 
                    toshow(i, j, next) = 0;
                    flag = 1;
                end
            end
        end
        next = next + 1;
    end
    flag = 1;
    while pre > 0 && flag && ~prev_next
        flag = 0;
        for i = 1:size(BW, 1)
            for j = 1:size(BW, 2)
                if BW(i, j) == 1 && ...
                        (toshow(i, j, pre) > 0 && toshow(i, j, pre) <= currentPixel && toshow(i, j, pre) >= minPixel) 
                    toshow(i, j, pre) = 0;
                    flag = 1;
                end
            end
        end
        pre = pre - 1;
    end
    display_refresh(img, tmp);
    save_history(1);
    return
end
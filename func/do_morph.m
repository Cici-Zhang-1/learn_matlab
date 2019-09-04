function do_morph(img, currentSlice)
    global toshow
    tmp = img.CData;
%     for i = 1:size(BW, 1)
%         for j = 1:size(BW, 2)
%             if BW(i, j) == 1
%                 tmp(i, j) = 0;
%             end
%         end
%     end
%     tmp = bwmorph(tmp,'open');
    se = strel('disk',2);
    afterOpening = imopen(tmp,se);
    toshow(:, :, currentSlice) = afterOpening;
%     next = currentSlice + 1;
%     pre = currentSlice - 1;
%     flag = 1;
%     while next <= maxSlice  && flag && direction && slice > 0 && slice <= maxSlice
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
%         if slice ~= 0
%             slice = slice - 1;
%         end
%     end
%     flag = 1;
%     while pre >= 1 && flag && ~direction && slice > 0 && slice <= maxSlice
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
%         if slice ~= 0
%             slice = slice - 1;
%         end
%     end
    display_refresh(img, afterOpening);
    save_history(1);
end
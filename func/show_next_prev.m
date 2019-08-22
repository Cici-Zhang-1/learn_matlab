% show the next or previous slice image
function a = show_next_prev(slice, s, img, currentSlice)
    global toshow
    slice = round(slice);
    s.Value = round(slice);
    a = slice;
    display_refresh(img, toshow(:, :, slice));
    currentSlice.String = num2str(slice);
    return
end


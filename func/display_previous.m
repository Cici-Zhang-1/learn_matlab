function display_previous(img, slice)
    global showHistory
    global minHistory
    global currentHistory
    global toshow
    if currentHistory <= minHistory
        return
    end
    currentHistory = currentHistory - 1;
    toshow = showHistory(:, :, :, currentHistory);
    display_refresh(img, toshow(:, :, slice));
    return
end
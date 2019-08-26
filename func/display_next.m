function display_next(img, slice)
    global showHistory
    global maxHistory
    global currentHistory
    global toshow
    if currentHistory >= maxHistory
        return
    end
    toshow = showHistory(:, :, :, currentHistory);
    currentHistory = currentHistory + 1;
    display_refresh(img, toshow(:, :, slice));
    return
end
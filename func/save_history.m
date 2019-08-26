% how to save history
% saveType 1: next
%          2: previous
function save_history (saveType)
    global showHistory
    global maxHistory
    global currentHistory
    global toshow
    if 1 == saveType
        currentHistory = currentHistory + 1;
        if currentHistory > 10
            showHistory = circshift(showHistory,-1, 4);
            currentHistory = 10;
        end
        maxHistory = currentHistory;
        showHistory(:, :, :, currentHistory) = toshow;
    else
    end
    
    return;
end
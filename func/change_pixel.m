function change_pixel(img, pixelEditor)
    global currentPixelX
    global currentPixelY
    global currentPixel
    [currentPixelX, currentPixelY] = ginput(1);
    currentPixelX = round(currentPixelX);
    currentPixelY = round(currentPixelY);
    currentPixel = img.CData(currentPixelY, currentPixelX);
    pixelEditor.String = currentPixel;
    return
end
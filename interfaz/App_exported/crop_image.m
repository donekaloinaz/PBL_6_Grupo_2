function cropped_image = crop_image(centre,I,bwselected)
diameter = calculate_diameter(bwselected);
if diameter < 400
    diameter =400;
end
row_start = centre(1) - ((round(diameter/2))+100);
row_end = centre(1) + ((round(diameter/2))+100);
col_start = centre(2) - ((round(diameter/2))+100);
col_end = centre(2) + ((round(diameter/2))+100);
if row_start <= 0
    row_start = 1;
end
if col_start <= 0
    col_start = 1;
end
if row_end >= width(I)
    row_end = width(I);
end
if col_end >= height(I)
    col_end = height(I);
end
if length(size(I)) == 3 
    cropped_image = I(col_start:col_end,row_start:row_end,:);
else
    cropped_image = I(col_start:col_end,row_start:row_end);
end
end
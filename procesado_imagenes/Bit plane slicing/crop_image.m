function cropped_image = crop_image(centre,I)
row_start = centre(1) - 300;
row_end = centre(1) + 300;
col_start = centre(2) - 300;
col_end = centre(2) + 300;
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
cropped_image = I(col_start:col_end,row_start:row_end,:);
end
function segmented_I = segment_rgb_image(bwselected,I)
rgb = im2double(I);
segmented_I = bsxfun(@times, rgb, double(bwselected));
end
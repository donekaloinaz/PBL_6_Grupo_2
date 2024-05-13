function [bw,bwselected,segmented_I,cropped_image,segblue] = Bit_plane_slicing_segmentation(I)
if mean(I(:,:,1),'all')>170
    segblue = true;
    blue_channel = double(I(:,:,2));
    bw = too_red_image(blue_channel);
else
    segblue = false;
    red_channel = double(I(:,:,1));
    bw = adequate_color_image(red_channel);
end
    [bwselected,centre] = selectseg(bw);
    segmented_I = segment_rgb_image(bwselected,I);
    cropped_image = crop_image(centre,I);
end
close all
clear
load imagenes_limpias_predict.mat
I = imagenlimpiarandom(imlimpiaspredict);
figure
imshow(I,[])
%% 
if mean(I(:,:,1),'all')>170
    blue_channel = double(I(:,:,2));
    bw = too_red_image(blue_channel);
    figure
    subplot(221)
    imshow(bw,[]); title('Segmentation by blue channel');
    [bwselected,centre] = selectseg(bw);
    subplot(222)
    imshow(bwselected,[]); title('Segmentation mask');
    segmented_I = segment_rgb_image(bwselected,I);
    subplot(223)
    imshow(segmented_I,[]); title('Segmented RGB image');
    cropped_image = crop_image(centre,I);
    subplot(224)
    imshow(cropped_image); title('Cropped RGB image');
else
    red_channel = double(I(:,:,1));
    bw = adequate_color_image(red_channel);
    figure
    subplot(221)
    imshow(bw,[]); title('Segmentation by red channel');
    [bwselected,centre] = selectseg(bw);
    subplot(222)
    imshow(bwselected,[]); title('Segmentation mask');
    segmented_I = segment_rgb_image(bwselected,I);
    subplot(223)
    imshow(segmented_I,[]); title('Segmented RGB image');
    cropped_image = crop_image(centre,I);
    subplot(224)
    imshow(cropped_image); title('Cropped RGB image');
end 
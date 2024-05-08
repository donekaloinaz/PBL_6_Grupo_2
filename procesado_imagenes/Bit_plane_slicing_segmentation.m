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
    imshow(bw,[]); title('Segmentation by blue channel');
else
    red_channel = double(I(:,:,1));
    bw = adequate_color_image(red_channel);
    figure
    imshow(bw,[]); title('Segmentation by red channel');
end 
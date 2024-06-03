clear; close all; clc;
load imagenes_limpias_predict.mat
[I,im_sin_str] = imagenlimpiarandom(imlimpiaspredict);
figure
imshow(I,[])
%% 
[VesselsRemoved,bw,bwselected,segmented_I,cropped_image_novessels,cropped_image_wvessels,centre,segblue] = Bit_plane_slicing_segmentation(I);
figure
subplot(221)
imshow(bw,[]);
if segblue == true
    title('Segmentación mediante canal verde');
else
    title('Segmentación mediante canal rojo');
end
subplot(222)
imshow(bwselected,[]); title('Máscara');
subplot(223)
imshow(segmented_I,[]); title('Imagen RGB segmentada');
subplot(224)
imshow(cropped_image_novessels); title('Imagen RGB recortada');
%% 
figure % 1450
subplot(221)
imshow(I,[]); title('Imagen original','FontSize',16);
subplot(222)
imshow(I(:,:,1),[]); title('Canal Rojo','FontSize',16);
subplot(223)
imshow(bwselected,[]); title('Segmentación disco','FontSize',16);
subplot(224)
imshow(cropped_image_wvessels,[]); title('ROI recortado','FontSize',16);
%% 
figure
subplot(121)
imshow(cropped_image_wvessels,[]); title('ROI recortado','FontSize',16);
subplot(122)
imshow(cropped_image_novessels,[]); title('ROI recortado sin vasos','FontSize',16);
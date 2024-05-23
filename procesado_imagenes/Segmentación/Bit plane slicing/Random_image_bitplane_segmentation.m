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
    title('Segmentación mediante canal azul');
else
    title('Segmentación mediante canal rojo');
end
subplot(222)
imshow(bwselected,[]); title('Máscara');
subplot(223)
imshow(segmented_I,[]); title('Imagen RGB segmentada');
subplot(224)
imshow(cropped_image_novessels); title('Imagen RGB recortada');
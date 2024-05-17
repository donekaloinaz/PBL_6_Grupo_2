close all
clear
load imagenes_limpias_predict.mat
I = imagenlimpiarandom(imlimpiaspredict);
%% 
figure
imshow(I,[])
[VesselsRemoved,bw,bwselected,segmented_I,cropped_image,segblue] = Bit_plane_slicing_segmentation(I);
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
imshow(cropped_image); title('Imagen RGB recortada');
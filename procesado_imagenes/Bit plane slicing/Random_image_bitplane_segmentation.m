close all
clear
load imagenes_limpias_predict.mat
I = imagenlimpiarandom(imlimpiaspredict);
figure
imshow(I,[])
[bw,bwselected,segmented_I,cropped_image,segblue] = Bit_plane_slicing_segmentation(I);
figure
subplot(221)
imshow(bw,[]);
if segblue == true
    title('Segmentation by blue channel');
else
    title('Segmentation by red channel');
end
subplot(222)
imshow(bwselected,[]); title('Segmentation mask');
subplot(223)
imshow(segmented_I,[]); title('Segmented RGB image');
subplot(224)
imshow(cropped_image); title('Cropped RGB image');
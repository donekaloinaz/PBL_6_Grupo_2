clear; close all; clc;
load imagenes_buenas.mat
%% 
I = imread(im_sin_str);
figure
subplot(121)
imshow(I,[]); title('Image')
subplot(122)
imhist(I); title('Histogram')
red_channel = double(I(:,:,1));
green_channel = double(I(:,:,2));
blue_channel = double(I(:,:,3));
figure
subplot(311)
imshow(red_channel,[]); title('Red Channel');
subplot(312)
imshow(green_channel,[]); title('Green Channel');
subplot(313)
imshow(blue_channel,[]); title('Blue Channel');
%% 
Vessels_Removed = RemoveVessels(I);
figure
imshow(Vessels_Removed,[]);
red_channel_vremoved = double(Vessels_Removed(:,:,1));
green_channel_vremoved = double(Vessels_Removed(:,:,2));
blue_channel_vremoved = double(Vessels_Removed(:,:,3));
figure
subplot(311)
imshow(red_channel_vremoved,[]); title('Red Channel');
subplot(312)
imshow(green_channel_vremoved,[]); title('Green Channel');
subplot(313)
imshow(blue_channel_vremoved,[]); title('Blue Channel');
%%
[VesselsRemoved, bw, bwselected, segmented_I, cropped_image_novessels, cropped_image_wvessels, segblue] = Bit_plane_slicing_segmentation(I);
Crop_Vessels_Removed = RemoveVessels(cropped_image_novessels);
figure
subplot(131)
imshow(Crop_Vessels_Removed,[]); title('Reremove vessels');
subplot(132)
imshow(cropped_image_novessels,[]); title('Only removed once');
subplot(133)
imshow(cropped_image_wvessels,[]); title('Vessels not removed')
%% 
bwgreen = blue_channel_bitplaneslicing(Crop_Vessels_Removed,5);
bwgreenselected = selectseg(bwgreen);
bwred = red_channel_bitplaneslicing(Crop_Vessels_Removed,5);
bwredselected = selectseg(bwred);
cupdiscmask = bwredselected-bwgreenselected;
figure
subplot(131)
imshow(bwredselected,[]); title('Optic disk');
subplot(132)
imshow(bwgreenselected,[]); title('Optic cup (1er intento)')
subplot(133)
imshow(cupdiscmask,[]); title('Disk/cup mask');
%% 
imforcup = uint8((double(Crop_Vessels_Removed(:,:,2))+double(Crop_Vessels_Removed(:,:,3)))/2);
imforcupadj = imadjust(imforcup);
imforcupadjgamma = im2uint8(imadjust(im2double(imforcupadj),[0 1],[0 1],1.5));
imforcupgamma = im2uint8(imadjust(im2double(imforcup),[min(im2double(imforcup(:))) max(im2double(imforcup(:)))],[0 1],1.5));
imforcupadjgammafilt = medfilt2(double(imforcupadjgamma),[5 5]);
lapfilt = [0 1 0; 1 -4 1; 0 1 0];
L = imfilter(imforcupadjgammafilt,lapfilt,'conv');
imforcupadjgammafilt = uint8(imforcupadjgammafilt-L);
figure
subplot(131)
imshow(imforcupgamma); title('directo');
subplot(132)
imshow(imforcupadjgamma); title('dospasos');
subplot(133)
imshow(imforcupadjgammafilt); title('dospasos filtrado')
cuplogical = select_last_bits(imforcupadjgamma);
cupdiscmask2 = bwredselected - cuplogical;
figure
subplot(131)
imshow(bwredselected,[]); title('Optic disk');
subplot(132)
imshow(cuplogical,[]); title('Optic cup (2o intento)')
subplot(133)
imshow(cupdiscmask2,[]); title('Disk/cup mask');
% Para sacar features hacer lo de rotar y contar longitud maxima para sacar
% el diametro, probar tambien pasar por filtros (pase bajo primero y luego
% pase alto) para binarizar mejor
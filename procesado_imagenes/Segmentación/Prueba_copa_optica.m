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
bwgreen = blue_channel_bitplaneslicing(cropped_image_novessels);
bwgreenselected = selectseg(bwgreen);
bwred = red_channel_bitplaneslicing(cropped_image_novessels);
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
imforcup = uint8((double(cropped_image_novessels(:,:,2))+double(cropped_image_novessels(:,:,3)))/2);
I1 = de2bi(imforcup);
bit1 = reshape(I1(:,1),size(imforcup));
bit2 = reshape(I1(:,2),size(imforcup));
bit3 = reshape(I1(:,3),size(imforcup));
bit4 = reshape(I1(:,4),size(imforcup));
bit5 = reshape(I1(:,5),size(imforcup));
bit6 = reshape(I1(:,6),size(imforcup));
bit7 = reshape(I1(:,7),size(imforcup));
bit8 = reshape(I1(:,8),size(imforcup));
cuplogical = logical(bit5)&logical(bit6)&logical(bit8);
se = strel('disk',20,8);
cuplogical = imclose(cuplogical,se);
cupdiscmask2 = bwredselected - cuplogical;
figure
subplot(131)
imshow(bwredselected,[]); title('Optic disk');
subplot(132)
imshow(cuplogical,[]); title('Optic cup (2o intento)')
subplot(133)
imshow(cupdiscmask2,[]); title('Disk/cup mask');
%% Otra prueba
bwcup = opticcup_bitplaneslicing(cropped_image_novessels);
bwcupselected = selectseg(bwcup);
cupdiscmask = bwredselected-bwcupselected;
figure
subplot(131)
imshow(bwredselected,[]); title('Optic disk');
subplot(132)
imshow(bwcupselected,[]); title('Optic cup (1er intento)')
subplot(133)
imshow(cupdiscmask,[]); title('Disk/cup mask');
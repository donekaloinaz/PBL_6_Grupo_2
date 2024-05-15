clear; close all; clc;
load imagen_delahostia.mat
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
[VesselsRemoved, bw, bwselected, segmented_I, cropped_image, segblue] = Bit_plane_slicing_segmentation(I);
Crop_Vessels_Removed = RemoveVessels(cropped_image);
figure
subplot(121)
imshow(Crop_Vessels_Removed,[]); title('Reremove vessels');
subplot(122)
imshow(cropped_image,[]); title('Only removed once');
%% 
bwgreen = green_channel_bitplaneslicing(cropped_image);
bwgreenselected = selectseg(bwgreen);
bwred = red_channel_bitplaneslicing(cropped_image);
bwredselected = selectseg(bwred);
cupdiscmask = bwredselected-bwgreenselected;
figure
subplot(131)
imshow(bwredselected,[]); title('Optic disk');
subplot(132)
imshow(bwgreenselected,[]); title('Optic cup (intento)')
subplot(133)
imshow(cupdiscmask,[]); title('Disk/cup mask')
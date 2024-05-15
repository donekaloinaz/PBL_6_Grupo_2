clear; close all; clc;
load imagenes_buenas.mat
%% 
I = imread(im_sin_str2);
figure
subplot(121)
imshow(I,[]); title('Image')
subplot(122)
imhist(I); title('Histogram')
red_channel = double(I(:,:,1));
green_channel = double(I(:,:,2));
blue_channel = double(I(:,:,3));
figure
subplot(131)
imshow(red_channel,[]); title('Red Channel');
subplot(132)
imshow(green_channel,[]); title('Green Channel');
subplot(133)
imshow(blue_channel,[]); title('Blue Channel');
%% 
VesselsRemoved = RemoveVessels(I);
figure
imshow(VesselsRemoved,[]);
red_channel_vremoved = double(VesselsRemoved(:,:,1));
green_channel_vremoved = double(VesselsRemoved(:,:,2));
blue_channel_vremoved = double(VesselsRemoved(:,:,3));
figure
subplot(131)
imshow(red_channel_vremoved,[]); title('Red Channel');
subplot(132)
imshow(green_channel_vremoved,[]); title('Green Channel');
subplot(133)
imshow(blue_channel_vremoved,[]); title('Blue Channel');

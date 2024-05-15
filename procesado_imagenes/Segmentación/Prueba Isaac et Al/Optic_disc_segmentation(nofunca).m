clear; close all; clc;
metadata=readtable("metadata.csv");
[im_sin,~,~] = find(metadata.quality==0);
sin = metadata(im_sin,:);
RAN=randi([1,height(sin)]);
im_sin_str = string(sin.image(RAN));
I= imread(im_sin_str);
figure
imshow(I,[])
%% Select red Channel
figure()
red_channel = I(:,:,1);
imshow(red_channel,[]); title('red Channel');
%% Image Preprocessing
red_mean = mean(red_channel,"all");
double_red_channel = double(red_channel);
red_std = std(double_red_channel(:));
mdf_red_channel = double_red_channel-(red_mean+red_std);
mdf_red_channel = uint8(mdf_red_channel);
figure
imshow(mdf_red_channel,[]);
%% Histogram Smoothing and Threshold definition (by formula in citation)
gauss = gausswin(100,8.25); %as per document, window size is 100 and standar deviation is 6, so by the formula alfa = (N-1)/(2*std) alfa is 8.25
gauss = gauss/sum(gauss); %normalized 
red_histogram = imhist(mdf_red_channel);
resultedhist = conv(red_histogram,gauss,'same');
figure
subplot(121)
plot(red_histogram); title('Original histogram');
subplot(122)
plot(resultedhist); title('Smoothed histogram');
std_gauss = 6;
mean_gauss = 50;
red_threshold = mean_gauss-(2*std_gauss)-red_std;
%% Image binarization by theoretic threshold
figure
imshow(mdf_red_channel>red_threshold,[])
kernel = strel('disk',100);
opticdisc_seg_theo = imclose(mdf_red_channel>red_threshold,kernel);
figure
imshow(opticdisc_seg_theo); title('Theoretical binarization');
%% Otsu method binarization
opticdisc_seg_otsu = imbinarize(mdf_red_channel,'global');
figure
imshow(opticdisc_seg_otsu); title('Otsu binarization');
%% Adaptive threshold binarization
opticdisc_seg_adaptive = imbinarize(mdf_red_channel,'adaptive','Sensitivity',0.001);
figure
imshow(opticdisc_seg_adaptive); title('Adaptive binarization');
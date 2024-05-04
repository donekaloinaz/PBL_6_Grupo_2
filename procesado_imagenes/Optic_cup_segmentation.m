clear; close all; clc;
metadata=readtable("metadata.csv");
[im_sin,~,~] = find(metadata.quality==0);
sin = metadata(im_sin,:);
RAN=randi([1,height(sin)]);
im_sin_str = string(sin.image(RAN));
I= imread(im_sin_str);
figure
imshow(I,[])
%% Select Green Channel
figure()
green_channel = I(:,:,2);
imshow(green_channel,[]); title('Green Channel');
%% Image Preprocessing
green_mean = mean(green_channel,"all");
double_green_channel = double(green_channel);
green_std = std(double_green_channel(:));
mdf_green_channel = double_green_channel-(green_mean+green_std);
mdf_green_channel = uint8(mdf_green_channel);
figure
imshow(mdf_green_channel,[]);
%% Histogram Smoothing and Threshold definition (by formula in citation)
gauss = gausswin(100,8.25); %as per document, window size is 100 and standar deviation is 6, so by the formula alfa = (N-1)/(2*std) alfa is 8.25
gauss = gauss/sum(gauss); %normalized 
green_histogram = imhist(mdf_green_channel);
resultedhist = conv(green_histogram,gauss,'same');
figure
subplot(121)
plot(green_histogram); title('Original histogram');
subplot(122)
plot(resultedhist); title('Smoothed histogram');
std_hist = std(resultedhist);
mean_hist = mean(resultedhist);
green_threshold = mean_hist + 2*std_hist + 2*green_std + green_mean;
%% Image binarization by theoretic threshold
figure
imshow(mdf_green_channel>green_threshold,[])
kernel = strel('disk',100);
opticcup_seg_theo = imclose(mdf_green_channel>green_threshold,kernel);
figure
imshow(opticcup_seg_theo); title('Theoretical binarization');
%% Otsu method binarization
opticcup_seg_otsu = imbinarize(mdf_green_channel,'global');
figure
imshow(opticcup_seg_otsu); title('Otsu binarization');
%% Adaptive threshold binarization
opticcup_seg_adaptive = imbinarize(mdf_green_channel,'adaptive','Sensitivity',0.001);
figure
imshow(opticcup_seg_adaptive); title('Adaptive binarization');
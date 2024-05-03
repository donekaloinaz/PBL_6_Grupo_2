clear; close all; clc;
metadata=readtable("metadata.csv");
[im_sin,~,~] = find(metadata.quality==0);
sin = metadata(im_sin,:);
RAN=randi([1,height(sin)]);
im_sin_str = string(sin.image(RAN));
I= imread(im_sin_str);
figure
imshow(I,[])
%% 
figure()
green_channel = I(:,:,2);
imshow(green_channel,[]); title('Green Channel');
%% 
green_mean = mean(green_channel,"all");
double_green_channel = double(green_channel);
green_var = var(double_green_channel(:))/1000;
mdf_green_channel = double_green_channel-(green_mean+green_var);
figure
mdf_green_channel = uint8(mdf_green_channel);
imshow(mdf_green_channel,[])
gauss = gausswin(100,8.25); %as per document, window size is 100 and standar deviation is 6, so by the formula alfa = (N-1)/(2*std) alfa is 8.25
green_histogram = imhist(mdf_green_channel);
resultedhist = conv(green_histogram,gauss,'same');
var_hist = var(resultedhist);
mean_hist = mean(resultedhist);
green_threhsold = mean_hist + 2*var_hist + 2*green_var + green_mean;
figure
imshow(mdf_green_channel>green_threhsold,[])
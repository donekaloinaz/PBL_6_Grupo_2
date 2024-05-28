clear; close all; clc; 
load imagenes_limpias_predict.mat;
load image_features.mat;
newfeatures = features;
k = 1;
for i = 1:length(imlimpiaspredict)
    I = imread(imlimpiaspredict(i));
    if mean(I(:,:,1),'all')>160
        rowtoelim(k) = i;
        k = k+1;
    end
end
%% 
array = 1:length(imlimpiaspredict);
imlimpiaspredict(rowtoelim) = [];
newfeatures(rowtoelim,:) = [];
array(rowtoelim) = [];
%% 
for i = 1:length(imlimpiaspredict)
    strim = strcat("ISNTcorrected",num2str(array(i)),".png");
    croppedim = imread(strim);
    strdisc = strcat("featuresfila",num2str(array(i)),".mat");
    load(strdisc)
    wavelet_features = Wavelet_features(double(croppedim).*double(disclogical));
    catwavelet = cat(2,wavelet_features.db2,wavelet_features.sym3,wavelet_features.bior31,wavelet_features.bior33,wavelet_features.bior35);
    for j = 1:30
        newfeatures{i,j+5} = catwavelet(j);
    end
end
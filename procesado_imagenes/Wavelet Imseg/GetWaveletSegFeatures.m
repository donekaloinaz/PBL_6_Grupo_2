clear; close all; clc;
features  = cell2table(cell(0,30), 'VariableNames', { ...
    'McHdb2','EcHdb2','McVdb2','EcVdb2','McDdb2','EcDdb2', ...
    'McHsym3','EcHsym3','McVsym3','EcVsym3','McDsym3','EcDsym3', ...
    'McHbior31','EcHbior31','McVbior31','EcVbior31','McDbior31','EcDbior31', ...
    'McHbior33','EcHbior33','McVbior33','EcVbior33','McDbior33','EcDbior33', ...
    'McHbior35','EcHbior35','McVbior35','EcVbior35','McDbior35','EcDbior35'});
load imagenes_limpias_predict.mat;
k = 1;
for i = 1:1237
    I = imread(imlimpiaspredict(i));
    if mean(I(:,:,1),'all')<160
        str = strcat("featuresfila",num2str(i),".mat");
        load(str)
        imseg = rgb2gray(croppedim).*uint8(disclogical);
        wavelet_features = Wavelet_features(imseg);
        catwavelet = cat(2,wavelet_features.db2,wavelet_features.sym3,wavelet_features.bior31,wavelet_features.bior33,wavelet_features.bior35);
        featurerow = num2cell(catwavelet);
        features(k,:) = featurerow;
        % figure
        % imshow(imseg)
        k = k+1;
    else
        clear I
    end
end
%% 
features = catpredictedseg(features);
save("ImSegOnlyRedWaveletFeatures.mat","features");
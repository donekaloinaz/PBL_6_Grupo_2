clear; close all; clc;
features  = cell2table(cell(0,91), 'VariableNames', { ...
    'AreaCup','AreaDisc','CuptoDiscRatio','ISNT','ISNTcupcorrected', ...
    'McHdb2','EcHdb2','McVdb2','EcVdb2','McDdb2','EcDdb2', ...
    'McHsym3','EcHsym3','McVsym3','EcVsym3','McDsym3','EcDsym3', ...
    'McHbior31','EcHbior31','McVbior31','EcVbior31','McDbior31','EcDbior31', ...
    'McHbior33','EcHbior33','McVbior33','EcVbior33','McDbior33','EcDbior33', ...
    'McHbior35','EcHbior35','McVbior35','EcVbior35','McDbior35','EcDbior35', ...
    'gabormedia1','gaborvarianza1','gaborstd1','gaborasimetria1','gaborkurtosis1','gaborentropia1','gaborenergia1', ...
    'gabormedia2','gaborvarianza2','gaborstd2','gaborasimetria2','gaborkurtosis2','gaborentropia2','gaborenergia2', ...
    'gabormedia3','gaborvarianza3','gaborstd3','gaborasimetria3','gaborkurtosis3','gaborentropia3','gaborenergia3', ...
    'gabormedia4','gaborvarianza4','gaborstd4','gaborasimetria4','gaborkurtosis4','gaborentropia4','gaborenergia4', ...
    'gabormedia5','gaborvarianza5','gaborstd5','gaborasimetria5','gaborkurtosis5','gaborentropia5','gaborenergia5', ...
    'gabormedia6','gaborvarianza6','gaborstd6','gaborasimetria6','gaborkurtosis6','gaborentropia6','gaborenergia6', ...
    'gabormedia7','gaborvarianza7','gaborstd7','gaborasimetria7','gaborkurtosis7','gaborentropia7','gaborenergia7', ...
    'gabormedia8','gaborvarianza8','gaborstd8','gaborasimetria8','gaborkurtosis8','gaborentropia8','gaborenergia8'});
load imagenes_limpias_predict
gaborbank = gabor([14.8,7.4],[0 45 90 135]); %https://www.sciencedirect.com/science/article/pii/S1746809414001396?ref=pdf_download&fr=RR-2&rr=88314aa1f90303ce
for i = 1:length(imlimpiaspredict)
    imstr = string(imlimpiaspredict(i));
    I = imread(imstr);
    [bwselected,~,centre,croppedim,disclogical,cuplogical,cupdiscmask,cupdiscmaskcorrected,ISNTadequate] = fullsegmentation(I);
    seg_features = Segmentation_features(cupdiscmask,cupdiscmaskcorrected,disclogical,cuplogical,centre,I,ISNTadequate);
    catseg = cat(2,seg_features.areacup,seg_features.areadisc,seg_features.cuptodiscratio,seg_features.ISNT,seg_features.ISNTcupcorrected);
    wavelet_features = Wavelet_features(croppedim);
    catwavelet = cat(2,wavelet_features.db2,wavelet_features.sym3,wavelet_features.bior31,wavelet_features.bior33,wavelet_features.bior35);
    gabor_features = Gabor_features(rgb2gray(croppedim),gaborbank);
    catgabor = cat(2,gabor_features.gabor1,gabor_features.gabor2,gabor_features.gabor3,gabor_features.gabor4,gabor_features.gabor5,gabor_features.gabor6,gabor_features.gabor7,gabor_features.gabor8);
    catfeatures = cat(2,catseg,catwavelet,catgabor);
    featurerow = num2cell(catfeatures);
    features(i,:) = featurerow;
    savename = strcat("featuresfila",num2str(i),".mat");
    save(savename,"featurerow","croppedim","disclogical","cuplogical","cupdiscmask","cupdiscmaskcorrected");
end
features = catpredicted(features);
save("image_features.mat","features");
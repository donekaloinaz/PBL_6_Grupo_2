function [glaufeatures, croppedim,edges] = get1ImageFeatures(I) 
    gaborbank = gabor([14.8,7.4],[0 45 90 135]); %https://www.sciencedirect.com/science/article/pii/S1746809414001396?ref=pdf_download&fr=RR-2&rr=88314aa1f90303ce
    [~,~,centre,croppedim,disclogical,cuplogical,cupdiscmask,cupdiscmaskcorrected,ISNTadequate,~] = fullsegmentation(I);
    seg_features = Segmentation_features(cupdiscmask,cupdiscmaskcorrected,disclogical,cuplogical,centre,I,ISNTadequate);
    catseg = cat(2,seg_features.areacup,seg_features.areadisc,seg_features.cuptodiscratio,seg_features.ISNT,seg_features.ISNTcupcorrected);
    wavelet_features = Wavelet_features(croppedim);
    catwavelet = cat(2,wavelet_features.db2,wavelet_features.sym3,wavelet_features.bior31,wavelet_features.bior33,wavelet_features.bior35);
    gabor_features = Gabor_features(rgb2gray(croppedim),gaborbank);
    catgabor = cat(2,gabor_features.gabor1,gabor_features.gabor2,gabor_features.gabor3,gabor_features.gabor4,gabor_features.gabor5,gabor_features.gabor6,gabor_features.gabor7,gabor_features.gabor8);
    catfeatures = cat(2,catseg,catwavelet,catgabor);
    glaufeatures(1,:) = catfeatures;
    edges=edge(cupdiscmaskcorrected);
end
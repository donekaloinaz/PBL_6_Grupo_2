function features = Gabor_features(I,gaborbank)
features = struct();
[mag,~] = imgaborfilt(I,gaborbank);
[media1,varianza1,desviacionstd1,asimetria1,curtosis1,entropia1,energia1] = getvals(mag(:,:,1));
features.gabor1 = [media1,varianza1,desviacionstd1,asimetria1,curtosis1,entropia1,energia1];
[media2,varianza2,desviacionstd2,asimetria2,curtosis2,entropia2,energia2] = getvals(mag(:,:,2));
features.gabor2 = [media2,varianza2,desviacionstd2,asimetria2,curtosis2,entropia2,energia2];
[media3,varianza3,desviacionstd3,asimetria3,curtosis3,entropia3,energia3] = getvals(mag(:,:,3));
features.gabor3 = [media3,varianza3,desviacionstd3,asimetria3,curtosis3,entropia3,energia3];
[media4,varianza4,desviacionstd4,asimetria4,curtosis4,entropia4,energia4] = getvals(mag(:,:,4));
features.gabor4 = [media4,varianza4,desviacionstd4,asimetria4,curtosis4,entropia4,energia4];
[media5,varianza5,desviacionstd5,asimetria5,curtosis5,entropia5,energia5] = getvals(mag(:,:,5));
features.gabor5 = [media5,varianza5,desviacionstd5,asimetria5,curtosis5,entropia5,energia5];
[media6,varianza6,desviacionstd6,asimetria6,curtosis6,entropia6,energia6] = getvals(mag(:,:,6));
features.gabor6 = [media6,varianza6,desviacionstd6,asimetria6,curtosis6,entropia6,energia6];
[media7,varianza7,desviacionstd7,asimetria7,curtosis7,entropia7,energia7] = getvals(mag(:,:,7));
features.gabor7 = [media7,varianza7,desviacionstd7,asimetria7,curtosis7,entropia7,energia7];
[media8,varianza8,desviacionstd8,asimetria8,curtosis8,entropia8,energia8] = getvals(mag(:,:,8));
features.gabor8 = [media8,varianza8,desviacionstd8,asimetria8,curtosis8,entropia8,energia8];
    function [media,varianza,desviacionstd,asimetria,curtosis,entropia,energia] = getvals(magnitude)
        media = mean(magnitude(:));
        varianza = var(magnitude(:));
        desviacionstd = std(magnitude(:));
        asimetria = skewness(magnitude(:));
        curtosis = kurtosis(magnitude(:));
        entropia = entropy(magnitude(:));
        energia = (1/((height(magnitude)^2)*(width(magnitude)^2)))*(sum(magnitude(:).^2));
    end
end
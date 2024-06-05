function features = catpredictedseg(features)
T = readtable("metadata.csv");
load imagenes_limpias_predict.mat
k = 1;
for i = 1:length(imlimpiaspredict)
    str = imlimpiaspredict(i);
    I = imread(str);
    if mean(I(:,:,1),'all')<160
        clear I
        [row,~] = find(strcmp(str,T.image));
        rowstokeep(k) = row;
        k = k+1;
    else
        clear I
    end
end
metadatapredict = T(rowstokeep,:);
features.Glaucoma = metadatapredict.glaucoma;
end
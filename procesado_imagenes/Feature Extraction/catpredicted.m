function features = catpredicted(features)
T = readtable("metadata.csv");
load imagenes_limpias_predict.mat
rowstokeep = zeros(1,length(imlimpiaspredict));
for i = 1:length(imlimpiaspredict)
    str = imlimpiaspredict(i);
    [row,~ ] = find(strcmp(str,T.image));
    rowstokeep(i) = row;
end
metadatapredict = T(rowstokeep,:);
features.Glaucoma = metadatapredict.glaucoma;
end
function features = getzscorefeatures(features)
array = [1:3,6:(width(features)-1)];
for i = 1:length(array)
    features.(array(i)) = zscore(features.(array(i)));
end
end
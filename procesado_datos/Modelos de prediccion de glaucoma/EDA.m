clear; close all; clc;
load image_features.mat; 
Y = features{:,end};
X = features{:,1:end-1};
cv = cvpartition(Y, 'HoldOut', 0.2, 'Stratify', true);
X_train = X(cv.training, :);
X_test  = X(cv.test, :);
Y_train = Y(cv.training);
Y_test  = Y(cv.test);
%% 
corrmap = corrcoef(X);
imagesc(corrmap);
colormap("hot")
%% 
corrglc = corrmap(:,end);
[sorted,order] = sort(corrglc);
varstotry = order(end-6:end-1);
%% 
for i = 1:width(features)-1
    corrs(i) = corr(X(:,i),Y);
end
[valmaxcorr,idxmaxcorr] = max(abs(corrs));
for i = 1:width(features)-1
    mdl = fitmnr(X_train(:,i),Y_train);
    [Y_pred,scores] = predict(mdl,X_test(:,i));
    cm = confusionmat(Y_test,Y_pred);
    acc(i) = (cm(1,1)+cm(2,2))/(cm(1,1)+cm(2,2)+cm(1,2)+cm(2,1));
    [~,~,~,auc(i)] = perfcurve(Y_test,scores(:,1),0);
end
[valacc,idxacc] = max(acc);
[valauc,idxauc] = max(auc);
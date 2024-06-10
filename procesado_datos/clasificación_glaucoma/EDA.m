clear; close all; clc;
load image_features.mat; 
Y = features{:,end};
X = features{:,1:end-1};
cv = cvpartition(Y, 'HoldOut', 0.2, 'Stratify', true);
X_train = X(cv.training, :);
X_test  = X(cv.test, :);
Y_train = Y(cv.training);
Y_test  = Y(cv.test);
variables = features.Properties.VariableNames;
%% 
corrmap = corrcoef(X);
ticks = {'Segmentación','Wavelet','Gabor'};
figure
imagesc(corrmap); title('Matriz de correlación');
xticks([3,22,63])
xticklabels(ticks)
xtickangle(30)
yticks([3,22,63])
yticklabels(ticks)
colormap("hot")
%% 
effect = zeros(1,width(table)-1);
for i = 1:width(features)-1
    table = meanEffectSize(features{:,i},features{:,end});
    effect(i) = table.Effect;
end
effect = effect./max(effect);
[B,I] = sort(effect);
string = variables(I(end-6:end));
% 
% corrglc = corrmap(:,end);
% [sorted,order] = sort(corrglc);
% varstotry = order(end-6:end-1);
%% 
% for i = 1:width(features)-1
%     corrs(i) = corr(X(:,i),Y);
% end
% [valmaxcorr,idxmaxcorr] = max(abs(corrs));
% for i = 1:width(features)
%     for j = 1:width(features)
%         mdl = fitmnr(X_train(:,i),Y_train);
%         [Y_pred,scores] = predict(mdl,X_test(:,i));
%         cm = confusionmat(Y_test,Y_pred);
%         acc(i) = (cm(1,1)+cm(2,2))/(cm(1,1)+cm(2,2)+cm(1,2)+cm(2,1));
%         [~,~,~,auc(i)] = perfcurve(Y_test,scores(:,1),0);
%     end
% end
% [valacc,idxacc] = max(acc);
% [valauc,idxauc] = max(auc);
clear; close all; clc;
load image_features.mat
rng("default")
%% Z-socre variables
features = getzscorefeatures(features);
%% Equal Partition
positive = features(features.Glaucoma==1,:);
negative = features(features.Glaucoma==0,:);
newt = positive;
newt(end+1:end+height(positive),:) = negative(1:height(positive),:);
variablenames = newt.Properties.VariableNames;
%% Data partition
Y = newt{:,end};
X = newt{:,1:end-1};
cv = cvpartition(Y, 'HoldOut', 0.2, 'Stratify', true);
X_train = X(cv.training, :);
X_test  = X(cv.test, :);
Y_train = Y(cv.training);
Y_test  = Y(cv.test);
%% Entrena
[bestmdl,varidx,~] = getrfe('ENS',X_train,Y_train);
%% Test
[Y_knn_pred, knn_scores] = predict(bestmdl, X_test(:,varidx));
figure('Name','Optimized ENSTrees Confusion Chart')
cm_knn = confusionchart(Y_test, Y_knn_pred, 'RowSummary','row-normalized');
cmvals_knn = cm_knn.NormalizedValues;
acc_knn_best = (cmvals_knn(1,1)+cmvals_knn(2,2))/(cmvals_knn(1,1)+cmvals_knn(2,2)+cmvals_knn(1,2)+cmvals_knn(2,1));
sen_knn_best = cmvals_knn(1,1)/(cmvals_knn(1,1)+cmvals_knn(2,1));
spe_knn_best = cmvals_knn(2,2)/(cmvals_knn(2,2)+cmvals_knn(1,2));
precis_knn_best = cmvals_knn(1,1)/(cmvals_knn(1,1)+cmvals_knn(1,2));
[~, ~, ~, auc_knn_best] = perfcurve(Y_test, knn_scores(:,1), 0);
%% Print
variablenames = variablenames(2:end);
variables = getvariablenames(varidx,variablenames);
fprintf(['Best model got an AUC of %.4f with the next variables: {%s}\n' ...
    'Other parameters:\n' ...
    'Accuracy: %.4f\n' ...
    'Sensitivity: %.4f\n' ...
    'Specificity: %.4f\n' ...
    'Precision: %.4f\n'],auc_knn_best,variables,acc_knn_best,sen_knn_best,spe_knn_best,precis_knn_best)
save('RFE_ENSTrees_model','bestmdl','varidx');
%% 
function variables = getvariablenames(varidx,variablenames)
variables = string(variablenames{1});
for i = 2:length(varidx)
    str = string(variablenames{i});
    variables = strcat(variables,"; ",str);
end
end
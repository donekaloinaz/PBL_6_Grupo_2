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
[bestmdl,varidx,~] = getrfe('SVM',X_train,Y_train);
%% Test
[Y_pred, scores] = predict(bestmdl, X_test(:,varidx));
figure('Name','Optimized SVM Confusion Chart')
cm = confusionchart(Y_test, Y_pred, 'RowSummary','row-normalized');
cmvals = cm.NormalizedValues;
acc = (cmvals(1,1)+cmvals(2,2))/(cmvals(1,1)+cmvals(2,2)+cmvals(1,2)+cmvals(2,1));
sen = cmvals(1,1)/(cmvals(1,1)+cmvals(2,1));
spe = cmvals(2,2)/(cmvals(2,2)+cmvals(1,2));
precis = cmvals(1,1)/(cmvals(1,1)+cmvals(1,2));
[~, ~, ~, auc] = perfcurve(Y_test, scores(:,1), 0);
%% Print
variablenames = variablenames(2:end);
variables = getvariablenames(varidx,variablenames);
fprintf(['Best model got an AUC of %.4f with the next variables: {%s}\n' ...
    'Other parameters:\n' ...
    'Accuracy: %.4f\n' ...
    'Sensitivity: %.4f\n' ...
    'Specificity: %.4f\n' ...
    'Precision: %.4f\n'],auc,variables,acc,sen,spe,precis)
save('RFE_SVM_model','bestmdl','varidx');
%% 
function variables = getvariablenames(varidx,variablenames)
variables = string(variablenames{1});
for i = 2:length(varidx)
    str = string(variablenames{i});
    variables = strcat(variables,"; ",str);
end
end
clear;
load image_features.mat
rng("default")
%% Z-socre variables
features = getzscorefeatures(features);
%% Equal Partition
positive = features(features.Glaucoma==1,:);
negative = features(features.Glaucoma==0,:);
newt = positive;
newt(end+1:end+height(positive),:) = negative(1:height(positive),:);
file = uigetfile('*.mat');
load(file)
%% Data partition
Y = newt{:,end};
X = newt{:,36:end-1};
cv = cvpartition(Y, 'HoldOut', 0.2, 'Stratify', true);
X_train = X(cv.training, :);
X_test  = X(cv.test, :);
Y_train = Y(cv.training);
Y_test  = Y(cv.test);
%% 
[Y_pred, scores] = predict(nb_mdl, X_test);
figure('Name','ENSknn Confusion Chart')
cm = confusionchart(Y_test, Y_pred, 'RowSummary','row-normalized');
cmvals = cm.NormalizedValues;
acc = (cmvals(1,1)+cmvals(2,2))/(cmvals(1,1)+cmvals(2,2)+cmvals(1,2)+cmvals(2,1));
sen = cmvals(1,1)/(cmvals(1,1)+cmvals(2,1));
spe = cmvals(2,2)/(cmvals(2,2)+cmvals(1,2));
precis0 = cmvals(1,1)/(cmvals(1,1)+cmvals(1,2));
precis1 = cmvals(2,2)/(cmvals(2,1)+cmvals(2,2));
[~, ~, ~, auc] = perfcurve(Y_test, scores(:,1), 0);
fprintf(['Best model got an AUC of %.4f \n' ...
    'Other parameters:\n' ...
    'Accuracy: %.4f\n' ...
    'Sensitivity: %.4f\n' ...
    'Specificity: %.4f\n' ...
    'Precision0: %.4f\n' ...
    'Precision1: %.4f\n'],auc,acc,sen,spe,precis0,precis1)
clear; close all; clc;
load image_features.mat
rng("default")
%% Z-socre variables
features = getzscorefeatures(features);
Y = features{:,end};
X = features{:,1:end-1};
cv = cvpartition(Y, 'HoldOut', 0.2, 'Stratify', true);
X_train = X(cv.training, :);
X_test  = X(cv.test, :);
Y_train = Y(cv.training);
Y_test  = Y(cv.test);
%% Model training with RFA (sequentialfs)
fun = @(XT,yT,Xt,yt) loss(fitcsvm(XT,yT,'OptimizeHyperparameters','all', ...
    'HyperparameterOptimizationOptions',opt), Xt, yt);
to_keep = sequentialfs(fun, X_train, Y_train,'Direction','backward');
%% Build final model
bestmdl = fitmnr(X_train(:,to_keep),Y_train);
[Y_ens_pred, ens_scores] = predict(bestmdl,X_test(:,to_keep));
figure('Name','Initial test ENS Confusion Chart')
cm_ens = confusionchart(Y_test, Y_ens_pred, 'RowSummary','row-normalized');
cmvals_ens = cm_ens.NormalizedValues;
acc_ens_inital = (cmvals_ens(1,1)+cmvals_ens(2,2))/(cmvals_ens(1,1)+cmvals_ens(2,2)+cmvals_ens(1,2)+cmvals_ens(2,1));
sen_ens_inital = cmvals_ens(1,1)/(cmvals_ens(1,1)+cmvals_ens(2,1));
spe_ens_inital = cmvals_ens(2,2)/(cmvals_ens(2,2)+cmvals_ens(1,2));
precis_ens_inital = cmvals_ens(1,1)/(cmvals_ens(1,1)+cmvals_ens(1,2));
[~, ~, ~, auc_ens_inital] = perfcurve(Y_test, ens_scores(:,1), 0);
variablenames = variablenames(2:end);
varidx = find(to_keep);
variables = getvariablenames(varidx,variablenames);
fprintf(['Best initial model got an AUC of %.4f with the next variables: {%s}\n' ...
    'Other parameters:\n' ...
    'Accuracy: %.4f\n' ...
    'Sensitivity: %.4f\n' ...
    'Specificity: %.4f\n' ...
    'Precision: %.4f\n'],auc_ens_inital,variables,acc_ens_inital,sen_ens_inital,spe_ens_inital,precis_ens_inital)
save("SVM_RFE_model.mat","bestmdl","varidx");
%% 
function variables = getvariablenames(varidx,variablenames)
variables = string(variablenames{1});
for i = 2:length(varidx)
    str = string(variablenames{i});
    variables = strcat(variables,"; ",str);
end
end
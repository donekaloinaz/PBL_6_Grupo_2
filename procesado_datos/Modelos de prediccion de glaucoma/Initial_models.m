clear; close all; clc;
load image_features.mat
rng("default")
%% Z-socre variables
features = getzscorefeatures(features);
%% Data partition
Y = features{:,end};
X = features{:,1:end-1};
cv = cvpartition(Y, 'HoldOut', 0.2, 'Stratify', true);
X_train = X(cv.training, :);
X_test  = X(cv.test, :);
Y_train = Y(cv.training);
Y_test  = Y(cv.test);
%% Multinomial Regression Model 
%A predicter model based on the multivariable logistic regression is created by the fitmnr function. Available data is separated bewteen training and testing data, 80% and 20% respectively. Stratification is applied to allow optimal testing to the algorithm.
mnr_mdl = fitmnr(X_train,Y_train);
%Model is tested 
[Y_mnr_pred, mnr_scores] = predict(mnr_mdl, X_test);
figure('Name','MNR Confusion Chart')
cm_mnr = confusionchart(Y_test, Y_mnr_pred, 'RowSummary','row-normalized');
cmvals_mnr = cm_mnr.NormalizedValues;
acc_mnr_test = (cmvals_mnr(1,1)+cmvals_mnr(2,2))/(cmvals_mnr(1,1)+cmvals_mnr(2,2)+cmvals_mnr(1,2)+cmvals_mnr(2,1));
sen_mnr_test = cmvals_mnr(1,1)/(cmvals_mnr(1,1)+cmvals_mnr(2,1));
spe_mnr_test = cmvals_mnr(2,2)/(cmvals_mnr(2,2)+cmvals_mnr(1,2));
precis_mnr_test = cmvals_mnr(1,1)/(cmvals_mnr(1,1)+cmvals_mnr(1,2));
[~, ~, ~, auc_mnr_test] = perfcurve(Y_test, mnr_scores(:,1), 0);
results = table;
results = [results; table("MNR", acc_mnr_test, sen_mnr_test, spe_mnr_test, precis_mnr_test, auc_mnr_test, 'VariableNames',{'model','accuracy','sensitivity','specificity','precision','AUC'})];

%% K-nearest Neighbors Model
cv_in = cvpartition(Y_train,"KFold",10);
opt.CVPartition = cv_in;
opt.Verbose = 0;
opt.ShowPlots = false;
knn_mdl_opt = fitcknn(X_train,Y_train,'OptimizeHyperparameters','all', ...
    'HyperparameterOptimizationOptions',opt);
[Y_knn_final_pred, knn_final_scores] = predict(knn_mdl_opt, X_test);
figure('Name','Optimized KNN Confusion Chart')
cm_knn_final = confusionchart(Y_test, Y_knn_final_pred, 'RowSummary','row-normalized');
cmvals_knn_final = cm_knn_final.NormalizedValues;
acc_knn_final_test = (cmvals_knn_final(1,1)+cmvals_knn_final(2,2))/(cmvals_knn_final(1,1)+cmvals_knn_final(2,2)+cmvals_knn_final(1,2)+cmvals_knn_final(2,1));
sen_knn_final_test = cmvals_knn_final(1,1)/(cmvals_knn_final(1,1)+cmvals_knn_final(2,1));
spe_knn_final_test = cmvals_knn_final(2,2)/(cmvals_knn_final(2,2)+cmvals_knn_final(1,2));
precis_knn_final_test = cmvals_knn_final(1,1)/(cmvals_knn_final(1,1)+cmvals_knn_final(1,2));
[~, ~, ~, auc_knn_final_test] = perfcurve(Y_test, knn_final_scores(:,1), 0);
results = [results; table("KNN", acc_knn_final_test, sen_knn_final_test, spe_knn_final_test, precis_knn_final_test, auc_knn_final_test, 'VariableNames',{'model','accuracy','sensitivity','specificity','precision','AUC'})];

%% Support Vector Machine
svm_mdl_opt = fitcsvm(X_train,Y_train,'OptimizeHyperparameters','all', ...
    'HyperparameterOptimizationOptions',opt);
[Y_svm_final_pred, svm_final_scores] = predict(svm_mdl_opt, X_test);
figure('Name','Optimized SVM Confusion Chart')
cm_svm_final = confusionchart(Y_test, Y_svm_final_pred, 'RowSummary','row-normalized');
cmvals_svm_final = cm_svm_final.NormalizedValues;
acc_svm_final_test = (cmvals_svm_final(1,1)+cmvals_svm_final(2,2))/(cmvals_svm_final(1,1)+cmvals_svm_final(2,2)+cmvals_svm_final(1,2)+cmvals_svm_final(2,1));
sen_svm_final_test = cmvals_svm_final(1,1)/(cmvals_svm_final(1,1)+cmvals_svm_final(2,1));
spe_svm_final_test = cmvals_svm_final(2,2)/(cmvals_svm_final(2,2)+cmvals_svm_final(1,2));
precis_svm_final_test = cmvals_svm_final(1,1)/(cmvals_svm_final(1,1)+cmvals_svm_final(1,2));
[~, ~, ~, auc_svm_final_test] = perfcurve(Y_test, svm_final_scores(:,1), 0);
results = [results; table("SVM", acc_svm_final_test, sen_svm_final_test, spe_svm_final_test, precis_svm_final_test, auc_svm_final_test, 'VariableNames',{'model','accuracy','sensitivity','specificity','precision','AUC'})];

%% Decision Trees
tree_mdl_opt = fitctree(X_train,Y_train,'OptimizeHyperparameters','all', ...
    'HyperparameterOptimizationOptions',opt);
[Y_tree_final_pred, tree_final_scores] = predict(tree_mdl_opt, X_test);
figure('Name','Optimized Tree Confusion Chart')
cm_tree_final = confusionchart(Y_test, Y_tree_final_pred, 'RowSummary','row-normalized');
cmvals_tree_final = cm_tree_final.NormalizedValues;
acc_tree_final_test = (cmvals_tree_final(1,1)+cmvals_tree_final(2,2))/(cmvals_tree_final(1,1)+cmvals_tree_final(2,2)+cmvals_tree_final(1,2)+cmvals_tree_final(2,1));
sen_tree_final_test = cmvals_tree_final(1,1)/(cmvals_tree_final(1,1)+cmvals_tree_final(2,1));
spe_tree_final_test = cmvals_tree_final(2,2)/(cmvals_tree_final(2,2)+cmvals_tree_final(1,2));
precis_tree_final_test = cmvals_tree_final(1,1)/(cmvals_tree_final(1,1)+cmvals_tree_final(1,2));
[~, ~, ~, auc_tree_final_test] = perfcurve(Y_test, tree_final_scores(:,1), 0);
imptree = predictorImportance(tree_mdl_opt);
results = [results; table("Tree", acc_tree_final_test, sen_tree_final_test, spe_tree_final_test, precis_tree_final_test, auc_tree_final_test, 'VariableNames',{'model','accuracy','sensitivity','specificity','precision','AUC'})];
%% Random Forest
rf_mdl = fitcensemble(X_train,Y_train,'Method','Bag','Learners','tree','NumLearningCycles',700);
[Y_rf_pred, rf_scores] = predict(rf_mdl,X_test);
figure('Name','Random Forest Confusion Chart');
cm_rf = confusionchart(Y_test,Y_rf_pred,'RowSummary','row-normalized');
cm_vals_rf = cm_rf.NormalizedValues;
sen_rf = cm_vals_rf(1,1)/(cm_vals_rf(1,1)+cm_vals_rf(2,1));
spe_rf = cm_vals_rf(2,2)/(cm_vals_rf(2,2)+cm_vals_rf(1,2));
precis_rf = cm_vals_rf(1,1)/(cm_vals_rf(1,1)+cm_vals_rf(1,2));
acc_rf = (cm_vals_rf(1,1)+cm_vals_rf(2,2))/(cm_vals_rf(1,1)+cm_vals_rf(2,2)+cm_vals_rf(1,2)+cm_vals_rf(2,1));
[~, ~, ~, auc_rf] = perfcurve(Y_test, rf_scores(:,1), 0);
results = [results; table("RF", acc_rf, sen_rf, spe_rf, precis_rf, auc_rf, 'VariableNames',{'model','accuracy','sensitivity','specificity','precision','AUC'})];
%% Naive Bayes
nb_mdl = fitcnb(X_train,Y_train,'OptimizeHyperparameters','all', ...
    'HyperparameterOptimizationOptions',opt);
[Y_nb_pred, nb_scores] = predict(nb_mdl, X_test);
figure('Name','Optimized NB Confusion Chart')
cm_nb = confusionchart(Y_test, Y_nb_pred, 'RowSummary','row-normalized');
cmvals_nb = cm_nb.NormalizedValues;
acc_nb = (cmvals_nb(1,1)+cmvals_nb(2,2))/(cmvals_nb(1,1)+cmvals_nb(2,2)+cmvals_nb(1,2)+cmvals_nb(2,1));
sen_nb = cmvals_nb(1,1)/(cmvals_nb(1,1)+cmvals_nb(2,1));
spe_nb = cmvals_nb(2,2)/(cmvals_nb(2,2)+cmvals_nb(1,2));
precis_nb = cmvals_nb(1,1)/(cmvals_nb(1,1)+cmvals_nb(1,2));
[~, ~, ~, auc_nb] = perfcurve(Y_test, nb_scores(:,1), 0);
results = [results; table("NB", acc_nb, sen_nb, spe_nb, precis_nb, auc_nb, 'VariableNames',{'model','accuracy','sensitivity','specificity','precision','AUC'})];
%% Optimized Ensemble Trees
ens_mdl = fitcensemble(X_train,Y_train,'Learners','tree','OptimizeHyperparameters','all', ...
    'HyperparameterOptimizationOptions',opt);
[ens_predict, ens_scores] = predict(ens_mdl,X_test);
figure('Name','Optimized Tree Ensembles Confusion Chart')
cm_ens = confusionchart(Y_test,ens_predict,'RowSummary','row-normalized');
cm_vals_ens = cm_ens.NormalizedValues;
acc_ens = (cm_vals_ens(1,1)+cm_vals_ens(2,2))/(cm_vals_ens(1,1)+cm_vals_ens(2,2)+cm_vals_ens(1,2)+cm_vals_ens(2,1));
sen_ens = cm_vals_ens(1,1)/(cm_vals_ens(1,1)+cm_vals_ens(2,1));
spe_ens = cm_vals_ens(2,2)/(cm_vals_ens(2,2)+cm_vals_ens(1,2));
precis_ens = cm_vals_ens(1,1)/(cm_vals_ens(1,1)+cm_vals_ens(1,2));
[~, ~, ~, auc_ens] = perfcurve(Y_test, ens_scores(:,1), 0);
results = [results; table("TreeENS", acc_ens, sen_ens, spe_ens, precis_ens, auc_ens, 'VariableNames',{'model','accuracy','sensitivity','specificity','precision','AUC'})];
%%
results
[max_acc, acc_idx] = max(results.accuracy);
[max_sen, sen_idx] = max(results.sensitivity);
[max_spe, spe_idx] = max(results.specificity);
[max_pre, pre_idx] = max(results.precision);
[max_AUC, AUC_idx] = max(results.AUC);
fprintf('The best accuracy was obtained by the %s model with a value of %.4f\n', results.model(acc_idx),max_acc)
fprintf('The best sensitivity was obtained by the %s model with a value of %.4f\n', results.model(sen_idx),max_sen)
fprintf('The best specificity was obtained by the %s model with a value of %.4f\n', results.model(spe_idx),max_spe)
fprintf('The best precision was obtained by the %s model with a value of %.4f\n', results.model(pre_idx),max_pre)
fprintf('The best AUC was obtaiend by the %s model with a value of %.4f\n', results.model(AUC_idx), max_AUC)
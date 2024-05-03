function first_model(firstfittable)
rng("default")
%% Data partition and fit options
class = firstfittable.class;
features = firstfittable{:,3:end};
cv = cvpartition(class, 'HoldOut', 0.3, 'Stratify', true);
features_train = features(cv.training, :);
features_test  = features(cv.test, :);
class_train = class(cv.training);
class_test  = class(cv.test);
cv_in = cvpartition(class_train,"KFold",10);
opt.CVPartition = cv_in;
opt.Verbose = 0;
opt.ShowPlots = false;
%% SVM Model 
svm_mdl_opt = fitcsvm(features_train,class_train,'OptimizeHyperparameters','auto', ...
    'HyperparameterOptimizationOptions',opt);
best_values_svm = table2struct(svm_mdl_opt.HyperparameterOptimizationResults.bestPoint);
stand_svm = returnstand(char(best_values_svm.Standardize));
svm_mdl = fitcsvm(features_train,class_train,'BoxConstraint',best_values_svm.BoxConstraint, ...
    'KernelScale',best_values_svm.KernelScale,'Standardize',stand_svm);
[class_svm_pred, svm_scores] = predict(svm_mdl, features_test);
figure('Name','Optimized SVM Confusion Chart')
cm_svm = confusionchart(class_test, class_svm_pred, 'RowSummary','row-normalized');
% cmvals_svm = cm_svm.NormalizedValues;
% acc_svm = (cmvals_svm(1,1)+cmvals_svm(2,2))/(cmvals_svm(1,1)+cmvals_svm(2,2)+cmvals_svm(1,2)+cmvals_svm(2,1));
% sen_svm = cmvals_svm(1,1)/(cmvals_svm(1,1)+cmvals_svm(2,1));
% spe_svm = cmvals_svm(2,2)/(cmvals_svm(2,2)+cmvals_svm(1,2));
% precis_svm = cmvals_svm(1,1)/(cmvals_svm(1,1)+cmvals_svm(1,2));
% [~, ~, ~, auc_svm] = perfcurve(class_test,svm_scores(:,1), 0);
save('svm_model','svm_mdl');
%% Regression Trees Model
tree_mdl_opt = fitctree(features_train,class_train,'OptimizeHyperparameters','auto', ...
    'HyperparameterOptimizationOptions',opt);
best_values_tree = table2struct(tree_mdl_opt.HyperparameterOptimizationResults.bestPoint);
tree_mdl = fitctree(features_train,class_train,'MinLeafSize',best_values_tree.MinLeafSize);
[class_tree_pred, tree_scores] = predict(tree_mdl, features_test);
figure('Name','Optimized Tree Confusion Chart')
cm_tree = confusionchart(class_test, class_tree_pred, 'RowSummary','row-normalized');
% cmvals_tree = cm_tree.NormalizedValues;
% acc_tree = (cmvals_tree(1,1)+cmvals_tree(2,2))/(cmvals_tree(1,1)+cmvals_tree(2,2)+cmvals_tree(1,2)+cmvals_tree(2,1));
% sen_tree = cmvals_tree(1,1)/(cmvals_tree(1,1)+cmvals_tree(2,1));
% spe_tree = cmvals_tree(2,2)/(cmvals_tree(2,2)+cmvals_tree(1,2));
% precis_tree = cmvals_tree(1,1)/(cmvals_tree(1,1)+cmvals_tree(1,2));
% [~, ~, ~, auc_tree] = perfcurve(class_test, tree_scores(:,1), 0);
imptree = predictorImportance(tree_mdl);
view(tree_mdl,'Mode','graph');
save('tree_model','tree_mdl');
%% Tree bagging with Random Forest Classification
% rf_mdl = fitensemble(features_train,class_train,'Bag',100,'Tree','Type','classification','CVPartition',cv_in);
rf_mdl = TreeBagger(100,features_train,class_train);
[class_rf_pred, rf_scores] = predict(rf_mdl,features_test);
figure('Name','Random Forest Confusion Chart')
cm_rf = confusionchart(class_test,str2num(cell2mat(class_rf_pred)),'RowSummary','row-normalized');
% cmvals_rf = cm_rf.NormalizedValues;
% acc_rf = (cmvals_rf(1,1)+cmvals_rf(2,2))/(cmvals_rf(1,1)+cmvals_rf(2,2)+cmvals_rf(1,2)+cmvals_rf(2,1));
% sen_rf = cmvals_rf(1,1)/(cmvals_rf(1,1)+cmvals_rf(2,1));
% spe_rf = cmvals_rf(2,2)/(cmvals_rf(2,2)+cmvals_rf(1,2));
% precis_rf = cmvals_rf(1,1)/(cmvals_rf(1,1)+cmvals_rf(1,2));
% [~, ~, ~, auc_rf] = perfcurve(class_test, rf_scores(:,1), 0);
%%
function stand = returnstand(str)
if strcmp(str,'true')
    stand = true;
else
    stand = false;
end
end
end
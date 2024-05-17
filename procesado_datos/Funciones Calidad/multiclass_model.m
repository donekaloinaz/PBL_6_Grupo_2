function results = multiclass_model(firstfittable)
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
results = struct();
%% SVM Model 
svm_mdl = fitcecoc(features_train,class_train,'OptimizeHyperparameters','auto', ...
    'HyperparameterOptimizationOptions',opt);
[class_svm_pred, svm_scores] = predict(svm_mdl, features_test);
figure('Name','Optimized SVM Confusion Chart')
cm_svm = confusionchart(class_test, class_svm_pred, 'RowSummary','row-normalized');
cmvals_svm = cm_svm.NormalizedValues;
acc_svm = (cmvals_svm(1,1)+cmvals_svm(2,2)+cmvals_svm(3,3)+cmvals_svm(4,4))/(sum(cmvals_svm,"all"));
%precis_svm = cmvals_svm(1,1)/(cmvals_svm(1,1)+cmvals_svm(1,2));
loss_svm = loss(svm_mdl,features_test,class_test);
% save('svm_model_multiclass.mat','svm_mdl');
%% Regression Trees Model
tree_mdl = fitctree(features_train,class_train,'OptimizeHyperparameters','auto', ...
    'HyperparameterOptimizationOptions',opt);
[class_tree_pred, tree_scores] = predict(tree_mdl, features_test);
figure('Name','Optimized Tree Confusion Chart')
cm_tree = confusionchart(class_test, class_tree_pred, 'RowSummary','row-normalized');
cmvals_tree = cm_tree.NormalizedValues;
acc_tree = (cmvals_tree(1,1)+cmvals_tree(2,2)+cmvals_tree(3,3)+cmvals_tree(4,4))/(sum(cmvals_tree,"all"));;
%precis_tree = cmvals_tree(1,1)/(cmvals_tree(1,1)+cmvals_tree(1,2));
loss_tree = loss(tree_mdl,features_test,class_test);
imptree = predictorImportance(tree_mdl);
% view(tree_mdl,'Mode','graph');
% save('tree_model_multiclass','tree_mdl');
%% Tree bagging with Random Forest Classification
rf_mdl = fitcensemble(features_train,class_train,'Method','Bag','Learners','Tree');
[class_rf_pred, rf_scores] = predict(rf_mdl,features_test);
figure('Name','Random Forest Confusion Chart')
cm_rf = confusionchart(class_test,class_rf_pred,'RowSummary','row-normalized');
cmvals_rf = cm_rf.NormalizedValues;
acc_rf = (cmvals_rf(1,1)+cmvals_rf(2,2)+cmvals_rf(3,3)+cmvals_rf(4,4))/(sum(cmvals_rf,"all"));
%precis_rf = cmvals_rf(1,1)/(cmvals_rf(1,1)+cmvals_rf(1,2));
loss_rf = loss(rf_mdl,features_test,class_test);
% save('random_forest_model_multiclass','rf_mdl');
%% Naive Bayes
nb_mdl = fitcnb(features_train,class_train,'OptimizeHyperparameters','auto', ...
    'HyperparameterOptimizationOptions',opt);
[class_nb_pred, nb_scores] = predict(nb_mdl, features_test);
figure('Name','Optimized NB Confusion Chart')
cm_nb = confusionchart(class_test, class_nb_pred, 'RowSummary','row-normalized');
cmvals_nb = cm_nb.NormalizedValues;
acc_nb = (cmvals_nb(1,1)+cmvals_nb(2,2)+cmvals_nb(3,3)+cmvals_nb(4,4))/(sum(cmvals_nb,"all"));
%precis_nb = cmvals_nb(1,1)/(cmvals_nb(1,1)+cmvals_nb(1,2));
loss_nb = loss(nb_mdl,features_test,class_test);
% save('naivebayes_model_multiclass','nb_mdl');
%% Save results
results.accuracy.svm = acc_svm;
results.accuracy.tree = acc_tree;
results.accuracy.rf = acc_rf;
results.accuracy.nb = acc_nb;
% results.precision.svm = precis_svm;
% results.precision.tree = precis_tree;
% results.precision.rf = precis_rf;
% results.precision.nb = precis_nb;
% results.error.svm = loss_svm;
% results.error.tree = loss_tree;
% results.error.rf = loss_rf;
% results.error.nb = loss_nb;
%% Create Final SVM Modela
cv_in2 = cvpartition(class,"KFold",10);
opt2.CVPartition = cv_in2;
opt2.Verbose = 0;
opt2.ShowPlots = false;
svm_final_mdl = fitcecoc(features,class,'OptimizeHyperparameters','auto', ...
    'HyperparameterOptimizationOptions',opt2);
save("Modelo_final_SVM","svm_final_mdl");
%%
function stand = returnstand(str)
if strcmp(str,'true')
    stand = true;
else
    stand = false;
end
end
end
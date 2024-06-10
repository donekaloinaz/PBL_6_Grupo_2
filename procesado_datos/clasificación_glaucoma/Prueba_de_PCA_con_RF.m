clear; close all; clc;
load image_features.mat
rng("default")
%% Z-socre variables
features = getzscorefeatures(features);
%% PCA
Y = features{:,end};
X = features{:,1:end-1};
cv = cvpartition(Y, 'HoldOut', 0.2, 'Stratify', true);
X_train = X(cv.training, :);
X_test  = X(cv.test, :);
Y_train = Y(cv.training);
Y_test  = Y(cv.test);
[coeff,score,latent,tsquared,explained,mu] = pca(X_train);
figure;
imagesc(coeff); colormap;
idx = find(cumsum(explained)>95,1);
trainscore = score(:,1:idx);

%% PCA plot
figure; subplot(121); hold on; title('Análisis PCA','FontSize',20);
scatter(score(Y_train==0, 1), score(Y_train==0, 2)); legend('Glaucoma negativo');
scatter(score(Y_train==1, 1), score(Y_train==1, 2)); lgd = legend('Glaucoma positivo','Glaucoma negativo'); fontsize(lgd,18,'points');
xlabel('PCA 1')
ylabel('PCA 2')

%% t-SNE
C= tsne(X_train);
subplot(122); hold on; title('Análisis t-SNE','FontSize',20);
scatter(C(Y_train==0, 1), C(Y_train==0, 2)); legend('Glaucoma negativo');
scatter(C(Y_train==1, 1), C(Y_train==1, 2)); lgd = legend('Glaucoma positivo','Glaucoma negativo'); fontsize(lgd,18,'points');
xlabel('t-SNE 1')
ylabel('t-SNE 2')
%% Train random forest
rf_mdl = fitcensemble(trainscore,Y_train,'Method','Bag','Learners','tree');
testscore = (X_test-mu)*coeff(:,1:idx);
[Y_rf_pred, rf_scores] = predict(rf_mdl,testscore);
figure('Name','RF Confusion Chart (PCA)');
cm_rf = confusionchart(Y_test,Y_rf_pred,'RowSummary','row-normalized');
cm_vals_rf = cm_rf.NormalizedValues;
sen_rf = cm_vals_rf(1,1)/(cm_vals_rf(1,1)+cm_vals_rf(2,1));
spe_rf = cm_vals_rf(2,2)/(cm_vals_rf(2,2)+cm_vals_rf(1,2));
precis_rf = cm_vals_rf(1,1)/(cm_vals_rf(1,1)+cm_vals_rf(1,2));
acc_rf = (cm_vals_rf(1,1)+cm_vals_rf(2,2))/(cm_vals_rf(1,1)+cm_vals_rf(2,2)+cm_vals_rf(1,2)+cm_vals_rf(2,1));
[~, ~, ~, auc_rf] = perfcurve(Y_test, rf_scores(:,1), 0);
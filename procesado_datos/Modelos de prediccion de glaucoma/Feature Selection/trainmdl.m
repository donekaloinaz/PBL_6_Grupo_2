function mdl = trainmdl(str,X_train,Y_train)
cv_in = cvpartition(Y_train,"KFold",10,"Stratify",true);
opt.CVPartition = cv_in;
opt.Verbose = 0;
opt.ShowPlots = false;
switch str
    case 'MNR'
        mdl = fitmnr(X_train,Y_train);
    case 'SVM'
        mdl = fitcsvm(X_train,Y_train,'OptimizeHyperparameters','all', ...
            'HyperparameterOptimizationOptions',opt);
    case 'RF'
        mdl = fitcensemble(X_train,Y_train,'Method','Bag','Learners','tree');
    case 'KNN'
        mdl = fitcknn(X_train,Y_train,'OptimizeHyperparameters','all', ...
            'HyperparameterOptimizationOptions',opt);
    case 'ENS'
        mdl = fitcensemble(X_train,Y_train,'Learners','tree','OptimizeHyperparameters','all', ...
            'HyperparameterOptimizationOptions',opt);
    case 'ENSdiscriminant'
        mdl = fitcensemble(X_train,Y_train,'Learners','discriminant','OptimizeHyperparameters','all', ...
            'HyperparameterOptimizationOptions',opt);
    case 'ENSknn'
        mdl = fitcensemble(X_train,Y_train,'Learners','knn','OptimizeHyperparameters','all', ...
            'HyperparameterOptimizationOptions',opt);
    case 'NB'
        mdl = fitcnb(X_train,Y_train,'OptimizeHyperparameters','all', ...
            'HyperparameterOptimizationOptions',opt);
end
end
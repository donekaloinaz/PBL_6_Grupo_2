function [mdl,varidx,incremental_auc] = getrfe(str,X,Y)
cv = cvpartition(Y,'HoldOut',0.2,'Stratify',true);
X_train = X(cv.training, :);
X_test  = X(cv.test, :);
Y_train = Y(cv.training);
Y_test  = Y(cv.test);
vars = 1:width(X_train);
initmdl = trainmdl(str,X_train,Y_train);
[~, initscores] = predict(initmdl, X_test);
[~, ~, ~, bestauc_out] = perfcurve(Y_test, initscores(:,1), 0);
incremental_auc = bestauc_out;
for i = 1:width(X_train)
    bestauc_in = 0;
    for j = 1:length(vars)
        varin = vars;
        varin(j) = [];
        in_mdl = trainmdl(str,X_train(:,varin),Y_train);
        [~, in_scores] = predict(in_mdl, X_test(:,varin));
        [~, ~, ~, auc_in] = perfcurve(Y_test, in_scores(:,1), 0);
        if auc_in > bestauc_in
            varout = varin;
            bestauc_in = auc_in;
            bestmdl_in = in_mdl;
        end
    end
    if bestauc_in > bestauc_out
        incremental_auc(i+1) = bestauc_in;
        varidx = varout;
        vars = varout;
        bestauc_out = bestauc_in;
        mdlout = bestmdl_in;
    else
        break
    end
end
A = exist("mdlout","var");
if A ~= 1
    mdl = initmdl;
    varidx = 1:width(X);
else
    mdl = mdlout;
end
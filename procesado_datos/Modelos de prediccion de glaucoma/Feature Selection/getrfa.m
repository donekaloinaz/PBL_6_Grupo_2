function [mdl,varidx,incremental_auc] = getrfa(str,X,Y)
cv = cvpartition(Y,'HoldOut',0.2,'Stratify',true);
X_train = X(cv.training, :);
X_test  = X(cv.test, :);
Y_train = Y(cv.training);
Y_test  = Y(cv.test);
auc_pervar = getmodelpervar(X_train,Y_train,X_test,Y_test);
idx = getbestaucidx(auc_pervar);
initmdl = trainmdl(str,X_train(:,idx(1)),Y_train);
[~, out_scores] = predict(initmdl, X_test(:,idx(1)));
[~, ~, ~, auc_init] = perfcurve(Y_test, out_scores(:,1), 0);
vars = idx(1);
idx(1) = [];
for i = 1:width(X_train)-1
    bestaucin = 0;
    for j = 1:length(idx)
        varin = vars;
        varin(end+1) = idx(j);
        in_mdl = trainmdl(str,X_train(:,varin),Y_train);
        [~, in_scores] = predict(in_mdl, X_test(:,varin));
        [~, ~, ~, auc_in] = perfcurve(Y_test, in_scores(:,1), 0);
        if auc_in > bestaucin
            vartoadd = j;
            bestaucin = auc_in;
            bestmdlin = in_mdl;
        end
    end
    vars(end+1) = idx(vartoadd);
    idx(vartoadd) = [];
    if bestaucin > auc_init
        incremental_auc(i) = bestaucin;
        mdlout = bestmdlin;
        varidx = vars;
        auc_init = bestaucin;
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
%%
function idx = getbestaucidx(auc_pervar)
idx = zeros(1,length(auc_pervar));
for p = 1:length(auc_pervar)
    [~,idx(p)] = max(auc_pervar);
    auc_pervar(idx(p)) = 0;
end
end
function auc_pervar = getmodelpervar(X_train,Y_train,X_test,Y_test)
auc_pervar = zeros(1,width(X_train));
for m = 1:width(X_train)
    mdlpervar = trainmdl(str,X_train(:,m),Y_train);
    [~, scores] = predict(mdlpervar, X_test(:,m));
    [~, ~, ~, auc_pervar(m)] = perfcurve(Y_test,scores(:,1), 0);
end
end
end
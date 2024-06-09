function features = Wavelet_features(I)
features = struct();
[~,cHdb2,cVdb2,cDdb2] = dwt2(I,"db2");
[McHdb2,McVdb2,McDdb2,EcHdb2,EcVdb2,EcDdb2] = getvals(cHdb2,cVdb2,cDdb2);
features.db2 = [McHdb2,EcHdb2,McVdb2,EcVdb2,McDdb2,EcDdb2];
[~,cHsym3,cVsym3,cDsym3] = dwt2(I,"sym3");
[McHsym3,McVsym3,McDsym3,EcHsym3,EcVsym3,EcDsym3] = getvals(cHsym3,cVsym3,cDsym3);
features.sym3 = [McHsym3,EcHsym3,McVsym3,EcVsym3,McDsym3,EcDsym3];
[~,cHbior31,cVbior31,cDbior31] = dwt2(I,"bior3.1");
[McHbior31,McVbior31,McDbior31,EcHbior31,EcVbior31,EcDbior31] = getvals(cHbior31,cVbior31,cDbior31);
features.bior31 = [McHbior31,EcHbior31,McVbior31,EcVbior31,McDbior31,EcDbior31];
[~,cHbior33,cVbior33,cDbior33] = dwt2(I,"bior3.3");
[McHbior33,McVbior33,McDbior33,EcHbior33,EcVbior33,EcDbior33] = getvals(cHbior33,cVbior33,cDbior33);
features.bior33 = [McHbior33,EcHbior33,McVbior33,EcVbior33,McDbior33,EcDbior33];
[~,cHbior35,cVbior35,cDbior35] = dwt2(I,"bior3.5");
[McHbior35,McVbior35,McDbior35,EcHbior35,EcVbior35,EcDbior35] = getvals(cHbior35,cVbior35,cDbior35);
features.bior35 = [McHbior35,EcHbior35,McVbior35,EcVbior35,McDbior35,EcDbior35];
    function [McH,McV,McD,EcH,EcV,EcD] = getvals(cH,cV,cD)
        McH = mean(cH(:));
        McV = mean(cV(:));
        McD = mean(cD(:));
        EcH = (1/((height(cH)^2)*(width(cH)^2)))*(sum(cH(:).^2));
        EcV = (1/((height(cV)^2)*(width(cV)^2)))*(sum(cV(:).^2));
        EcD = (1/((height(cD)^2)*(width(cD)^2)))*(sum(cD(:).^2));
    end
end
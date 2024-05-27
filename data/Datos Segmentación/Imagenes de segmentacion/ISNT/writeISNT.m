clear
for i = 1:1237
    str = strcat("featuresfila",num2str(i),".mat");
    load(str);
    writestr = strcat("ISNTcorrected",num2str(i),".png");
    imwrite(croppedim,writestr);
end

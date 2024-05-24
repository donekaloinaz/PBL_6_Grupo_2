function segfeatures = Segmentation_features(bwseg,bwcupcorrected,discseg,cupseg,centre,I,ISNTadequate)
%% Areas and ratio
diametercup = calculate_diameter(cupseg);
areacup = pi*(diametercup/2)^2;
diameterdisc = calculate_diameter(discseg);
areadisc = pi*(diameterdisc/2)^2;
cuptodiscratio = areacup/areadisc;
%% ISNT rule
ISNT = calcISNT(bwseg,centre,I,ISNTadequate);
%%
ISNTcupcorrected = calcISNT(bwcupcorrected,centre,I,ISNTadequate);
%% Build features struct
segfeatures.areacup = areacup;
segfeatures.areadisc = areadisc;
segfeatures.diametercup = diametercup;
segfeatures.diameterdisc = diameterdisc;
segfeatures.cuptodiscratio = cuptodiscratio;
segfeatures.ISNT = ISNT;
segfeatures.ISNTcupcorrected = ISNTcupcorrected;
end
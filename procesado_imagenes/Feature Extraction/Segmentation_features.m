function segfeatures = Segmentation_features(bwseg,bwcupcorrected,discseg,cupseg,centre,I)
%% Areas and ratio
diametercup = calculate_diameter(cupseg);
areacup = pi*(diametercup/2)^2;
diameterdisc = calculate_diamater(discseg);
areadisc = pi*(diameterdisc/2)^2;
cuptodiscratio = areacup/areadisc;
%% ISNT rule
ISNT = calcISNT(bwseg,centre,I);
%%
ISNTcupcorrected = calcISNT(bwseg,bwcupcorrected,centre,I)
%% Build features struct
segfeatures.areacup = arecup;
segfeatures.areadisc = areadisc;
segfeatures.cuptodiscratio = cuptodiscratio;
segfeatures.ISNT = ISNT;
end
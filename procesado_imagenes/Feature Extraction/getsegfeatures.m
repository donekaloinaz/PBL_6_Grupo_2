function segfeatures = getsegfeatures(bwseg,discseg,cupseg)
diametercup = calculate_diameter(cupseg);
areacup = pi*(diametercup/2)^2;
diameterdisc = calculate_diamater(discseg);
areadisc = pi*(diameterdisc/2)^2;
cuptodiscratio = areacup/areadisc;
segfeatures.areacup = arecup;
segfeatures.areadisc = areadisc;
segfeatures.cuptodiscratio = cuptodiscratio;
end
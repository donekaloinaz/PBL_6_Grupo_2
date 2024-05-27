function [bwselected,cropped_image_wvessels,cropcentre,Crop_Vessels_Removed,disclogical,cuplogical,cupdiscmask,cupdiscmaskcorrected,ISNTadequate,seggreen] = origfullsegmentation(I)
[~, ~, bwselected, ~, cropped_image_novessels, cropped_image_wvessels, origcentre, seggreen] = Bit_plane_slicing_segmentation(I);
Crop_Vessels_Removed = RemoveVessels(cropped_image_novessels);
disclogical = crop_image(origcentre,bwselected,bwselected);
centre = regionprops(disclogical,'Centroid');
centre = cat(1,centre.Centroid);
cropcentre = [round(centre(1,1)), round(centre(1,2))];
[cuplogical,imforcupadjgamma] = getcuplogical(Crop_Vessels_Removed);
cupdiscmask = disclogical - cuplogical;
if length(unique(cupdiscmask)) ~= 2
    ISNTadequate = false;
else
    ISNTadequate = true;
end
if cropcentre(2) > (width(I)/2)
    rightside = -1;
else
    rightside = 1;
end
cupcorrected = select_last_bits(imforcupadjgamma,rightside);
cupdiscmaskcorrected = disclogical - cupcorrected;
end
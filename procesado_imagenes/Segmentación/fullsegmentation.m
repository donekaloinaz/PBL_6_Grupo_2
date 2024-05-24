function [bwselected,cropped_image_novessels,cropcentre,Crop_Vessels_Removed,disclogical,cuplogical,cupdiscmask,cupdiscmaskcorrected,ISNTadequate] = fullsegmentation(I)
[~, ~, bwselected, ~, cropped_image_novessels, ~, origcentre, ~] = Bit_plane_slicing_segmentation(I);
Crop_Vessels_Removed = RemoveVessels(cropped_image_novessels);
disclogical = crop_image(origcentre,bwselected,bwselected);
centre = regionprops(disclogical,'Centroid');
cropcentre = [round(centre.Centroid(1)), round(centre.Centroid(2))];
imforcup = uint8((double(Crop_Vessels_Removed(:,:,2))+double(Crop_Vessels_Removed(:,:,3)))/2);
imforcupadj = imadjust(imforcup);
imforcupadjgamma = im2uint8(imadjust(im2double(imforcupadj),[0 1],[0 1],1.5));
cuplogical = select_last_bits_old(imforcupadjgamma);
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
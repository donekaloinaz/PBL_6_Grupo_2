function fullsegmentation(I)
[VesselsRemoved, bw, bwselected, segmented_I, cropped_image_novessels, cropped_image_wvessels, centre, segblue] = Bit_plane_slicing_segmentation(I);
Crop_Vessels_Removed = RemoveVessels(cropped_image_novessels);
disclogical = crop_image(centre,bwselected,bwselected);
imforcup = uint8((double(Crop_Vessels_Removed(:,:,2))+double(Crop_Vessels_Removed(:,:,3)))/2);
imforcupadj = imadjust(imforcup);
imforcupadjgamma = im2uint8(imadjust(im2double(imforcupadj),[0 1],[0 1],1.5));
cuplogical = select_last_bits_old(imforcupadjgamma);
cupdiscmask = disclogical - cuplogical;
if centre(2) > (width(I)/2)
    rightside = -1;
else
    rightside = 1;
end
cupcorrected = select_last_bits(imforcupadjgamma,rightside);
cupdiscmaskcorrected = disclogical - cupcorrected;
end
function cuplogical = getcuplogical(Crop_Vessels_Removed)
imforcup = uint8((double(Crop_Vessels_Removed(:,:,2))+double(Crop_Vessels_Removed(:,:,3)))/2);
imforcupadj = imadjust(imforcup);
imforcupadjgamma = im2uint8(imadjust(im2double(imforcupadj),[0 1],[0 1],1.5));
cuplogical = select_last_bits_old(imforcupadjgamma);
end
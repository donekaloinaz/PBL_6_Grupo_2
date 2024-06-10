function [VesselsRemoved,bw,bwselected,segmented_I,cropped_image_novessels,cropped_image_wvessels,centre,segblue] = Bit_plane_slicing_segmentation(I)
    VesselsRemoved = RemoveVessels(I);
    if mean(VesselsRemoved(:,:,1),'all')>160
        segblue = true;
        bw = green_channel_bitplaneslicing(VesselsRemoved,20);
    else
        segblue = false;
        bw = red_channel_bitplaneslicing(VesselsRemoved,20);
    end
    [bwselected,centre] = selectseg(bw);
    segmented_I = segment_rgb_image(bwselected,VesselsRemoved);
    cropped_image_novessels = crop_image(centre,VesselsRemoved,bwselected);
    cropped_image_wvessels = crop_image(centre,I,bwselected);
end
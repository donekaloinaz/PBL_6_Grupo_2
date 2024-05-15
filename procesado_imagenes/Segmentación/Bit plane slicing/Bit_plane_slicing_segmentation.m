function [VesselsRemoved,bw,bwselected,segmented_I,cropped_image,segblue] = Bit_plane_slicing_segmentation(I)
    VesselsRemoved = RemoveVessels(I);
    if mean(VesselsRemoved(:,:,1),'all')>170
        segblue = true;
        bw = blue_channel_bitplaneslicing(VesselsRemoved);
    else
        segblue = false;
        bw = red_channel_bitplaneslicing(VesselsRemoved);
    end
    [bwselected,centre] = selectseg(bw);
    segmented_I = segment_rgb_image(bwselected,VesselsRemoved);
    cropped_image = crop_image(centre,VesselsRemoved,bwselected);
end
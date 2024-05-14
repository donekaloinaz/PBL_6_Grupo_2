function bw = too_red_image(blue_channel)
    figure
    imshow(blue_channel,[]);
    std_blue = std(blue_channel(:));
    preproc_blue_channel = uint8(blue_channel-(std_blue));
    adj_preproc = imadjust(preproc_blue_channel);
    figure
    imshow(adj_preproc,[]);
    bipreproc = de2bi(preproc_blue_channel);
    bit1 = reshape(bipreproc(:,1),size(blue_channel));
    bit2 = reshape(bipreproc(:,2),size(blue_channel));
    bit3 = reshape(bipreproc(:,3),size(blue_channel));
    bit4 = reshape(bipreproc(:,4),size(blue_channel));
    bit5 = reshape(bipreproc(:,5),size(blue_channel));
    bit6 = reshape(bipreproc(:,6),size(blue_channel));
    bit7 = reshape(bipreproc(:,7),size(blue_channel));
    bit8 = reshape(bipreproc(:,8),size(blue_channel));
    % figure()
    % subplot(421)
    % imshow(bit1,[])
    % subplot(422)
    % imshow(bit2,[])
    % subplot(423)
    % imshow(bit3,[])
    % subplot(424)
    % imshow(bit4,[])
    % subplot(425)
    % imshow(bit5,[])
    % subplot(426)
    % imshow(bit6,[])
    % subplot(427)
    % imshow(bit7,[])
    % subplot(428)
    % imshow(bit8,[])
    bw = bit8;
    se = strel('disk',20,8);
    bw = imopen(bw,se);
    bw = imclose(bw,se);
end
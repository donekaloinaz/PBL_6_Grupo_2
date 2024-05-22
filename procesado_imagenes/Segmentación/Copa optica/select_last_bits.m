function bw = select_last_bits(I)
    single_channel = double(I);
    stdsingle = std(single_channel(:));
    single_channel = single_channel - stdsingle;
    %figure
    %imshow(single_channel,[]);
    preproc_single_channel8 = uint8(single_channel);
    adj_preproc = imadjust(preproc_single_channel8);
    %figure
    %imshow(adj_preproc,[])
    I1 = de2bi(adj_preproc);
    bit7 = reshape(I1(:,7),size(single_channel));
    bit8 = reshape(I1(:,8),size(single_channel));
    initbw = logical(bit7) & logical(bit8);
    bw = selectseg(initbw);
end
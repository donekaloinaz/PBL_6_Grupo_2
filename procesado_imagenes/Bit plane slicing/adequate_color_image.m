function bw = adequate_color_image(red_channel)
    stdred = std(red_channel(:));
    red_channel = red_channel - stdred;
    figure
    imshow(red_channel,[]);
    figure
    preproc_red_channel8 = uint8(red_channel);
    imhist(preproc_red_channel8);
    adj_preproc = imadjust(preproc_red_channel8);
    figure
    imhist(adj_preproc)
    figure
    imshow(adj_preproc,[])
    I1 = de2bi(adj_preproc);
    bit1 = reshape(I1(:,1),size(red_channel));
    bit2 = reshape(I1(:,2),size(red_channel));
    bit3 = reshape(I1(:,3),size(red_channel));
    bit4 = reshape(I1(:,4),size(red_channel));
    bit5 = reshape(I1(:,5),size(red_channel));
    bit6 = reshape(I1(:,6),size(red_channel));
    bit7 = reshape(I1(:,7),size(red_channel));
    bit8 = reshape(I1(:,8),size(red_channel));
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
    label_area = zeros(1,11);
    label_circ = zeros(1,11);
    label_per = zeros(1,11);
    label_ecc = zeros(1,11);
    se = strel('disk',20,8);
    for i = 1:11
        switch i
            case 1
                seg = logical(bit6) & logical(bit7) & logical(bit5) & logical(bit4);
                segopen = imopen(seg,se);
            case 2
                seg = logical(bit6) & logical(bit7) & logical(bit5);
                segopen = imopen(seg,se);
            case 3
                seg = logical(bit6) & logical(bit7) & logical(bit4);
                segopen = imopen(seg,se);
            case 4
                seg = logical(bit7) & logical(bit5) & logical(bit4);
                segopen = imopen(seg,se);
            case 5
                seg = logical(bit6) & logical(bit5) & logical(bit4);
                segopen = imopen(seg,se);
            case 6
                seg = logical(bit6) & logical(bit7);
                segopen = imopen(seg,se);
            case 7
                seg = logical(bit7) & logical(bit5);
                segopen = imopen(seg,se);
            case 8
                seg = logical(bit7) & logical(bit4);
                segopen = imopen(seg,se);
            case 9
                seg = logical(bit6) & logical(bit5);
                segopen = imopen(seg,se);
            case 10
                seg = logical(bit6) & logical(bit4);
                segopen = imopen(seg,se);
            case 11
                seg = logical(bit5) & logical(bit4);
                segopen = imopen(seg,se);
        end
        statsd = regionprops(segopen,'Circularity','Centroid',"Area","BoundingBox","Perimeter","Eccentricity");
        dotper = cat(1,statsd.Perimeter);
        dotarea = cat(1,statsd.Circularity);
        dotcirc = cat(1,statsd.Area);
        dotecc = cat(1,statsd.Eccentricity);
        compcirc=isinf(dotcirc)==0;
        dotcirc=dotcirc.*compcirc;
        dotarea=dotarea.*compcirc;
        dotper=dotper.*compcirc;
        dotecc=dotecc.*compcirc;
        dotcircnorm = dotcirc/max(dotcirc);
        L=0;
        x = 1;
        for j = 1:height(dotcircnorm)
            if dotcircnorm(j) < 0.5
                L(x) = j;
                x = x+1;
            end
        end
        dotcircnorm(dotcircnorm<0.5) = [];
        if L~=0
            dotarea(L,:) = [];
            dotper(L,:) = [];
            dotecc(L,:) = [];
        end
        [~,idx] = max(dotarea);
        label_circ(i)=dotcirc(idx);
        label_area(i)=dotarea(idx);
        label_per(i)=dotper(idx);
        label_ecc(i)=dotecc(idx);
    end
    ratios = label_circ.*(label_area./(label_per.*label_ecc));
    [~,ratio_idx] = max(ratios);
    switch ratio_idx
        case 1
            seg = logical(bit6) & logical(bit7) & logical(bit5) & logical(bit4);
            segopen = imopen(seg,se);
        case 2
            seg = logical(bit6) & logical(bit7) & logical(bit5);
            segopen = imopen(seg,se);
        case 3
            seg = logical(bit6) & logical(bit7) & logical(bit4);
            segopen = imopen(seg,se);
        case 4
            seg = logical(bit7) & logical(bit5) & logical(bit4);
            segopen = imopen(seg,se);
        case 5
            seg = logical(bit6) & logical(bit5) & logical(bit4);
            segopen = imopen(seg,se);
        case 6
            seg = logical(bit6) & logical(bit7);
            segopen = imopen(seg,se);
        case 7
            seg = logical(bit7) & logical(bit5);
            segopen = imopen(seg,se);
        case 8
            seg = logical(bit7) & logical(bit4);
            segopen = imopen(seg,se);
        case 9
            seg = logical(bit6) & logical(bit5);
            segopen = imopen(seg,se);
        case 10
            seg = logical(bit6) & logical(bit4);
            segopen = imopen(seg,se);
        case 11
            seg = logical(bit5) & logical(bit4);
            segopen = imopen(seg,se);
    end
    bw = segopen;
end
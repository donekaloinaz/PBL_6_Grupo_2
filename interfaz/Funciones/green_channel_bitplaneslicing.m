function bw = green_channel_bitplaneslicing(I,strelsize)
    green_channel = double(I(:,:,2));
    % figure
    % imshow(green_channel,[]);
    std_green = std(green_channel(:));
    preproc_green_channel = uint8(green_channel-(std_green));
    adj_preproc = imadjust(preproc_green_channel);
    %figure
    %imshow(adj_preproc,[]);
    bipreproc = de2bi(adj_preproc);
    bit1 = reshape(bipreproc(:,1),size(green_channel));
    bit2 = reshape(bipreproc(:,2),size(green_channel));
    bit3 = reshape(bipreproc(:,3),size(green_channel));
    bit4 = reshape(bipreproc(:,4),size(green_channel));
    bit5 = reshape(bipreproc(:,5),size(green_channel));
    bit6 = reshape(bipreproc(:,6),size(green_channel));
    bit7 = reshape(bipreproc(:,7),size(green_channel));
    bit8 = reshape(bipreproc(:,8),size(green_channel));
    % figure()
    % subplot(421)
    % imshow(bit1,[])
    % subplot(422)
    % imshow(bit2,[])
    % subplot(423)
    % imshow(bit3,[])
    % subplot(424)
    % imshow(bit8,[])
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
    se = strel('disk',strelsize,8);
    for i = 1:11
        switch i
            case 1
                seg = logical(bit6) & logical(bit7) & logical(bit5) & logical(bit8);
                seg = imopen(seg,se);
            case 2
                seg = logical(bit6) & logical(bit7) & logical(bit5);
                seg = imopen(seg,se);
            case 3
                seg = logical(bit6) & logical(bit7) & logical(bit8);
                seg = imopen(seg,se);
            case 4
                seg = logical(bit7) & logical(bit5) & logical(bit8);
                seg = imopen(seg,se);
            case 5
                seg = logical(bit6) & logical(bit5) & logical(bit8);
                seg = imopen(seg,se);
            case 6
                seg = logical(bit6) & logical(bit7);
                seg = imopen(seg,se);
            case 7
                seg = logical(bit7) & logical(bit5);
                seg = imopen(seg,se);
            case 8
                seg = logical(bit7) & logical(bit8);
                seg = imopen(seg,se);
            case 9
                seg = logical(bit6) & logical(bit5);
                seg = imopen(seg,se);
            case 10
                seg = logical(bit6) & logical(bit8);
                seg = imopen(seg,se);
            case 11
                seg = logical(bit5) & logical(bit8);
                seg = imopen(seg,se);
        end
        statsd = regionprops(seg,'Circularity','Centroid',"Area","BoundingBox","Perimeter","Eccentricity");
        if ~isempty(statsd)
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
        else
            label_circ(i)=nan;
            label_area(i)=nan;
            label_per(i)=nan;
            label_ecc(i)=nan;
        end
    end
    ratios = label_circ.*(label_area./(label_per.*label_ecc));
    [~,ratio_idx] = max(ratios);
    switch ratio_idx
        case 1
            seg = logical(bit6) & logical(bit7) & logical(bit5) & logical(bit8);
            seg = imopen(seg,se);
        case 2
            seg = logical(bit6) & logical(bit7) & logical(bit5);
            seg = imopen(seg,se);
        case 3
            seg = logical(bit6) & logical(bit7) & logical(bit8);
            seg = imopen(seg,se);
        case 4
            seg = logical(bit7) & logical(bit5) & logical(bit8);
            seg = imopen(seg,se);
        case 5
            seg = logical(bit6) & logical(bit5) & logical(bit8);
            seg = imopen(seg,se);
        case 6
            seg = logical(bit6) & logical(bit7);
            seg = imopen(seg,se);
        case 7
            seg = logical(bit7) & logical(bit5);
            seg = imopen(seg,se);
        case 8
            seg = logical(bit7) & logical(bit8);
            seg = imopen(seg,se);
        case 9
            seg = logical(bit6) & logical(bit5);
            seg = imopen(seg,se);
        case 10
            seg = logical(bit6) & logical(bit8);
            seg = imopen(seg,se);
        case 11
            seg = logical(bit5) & logical(bit8);
            seg = imopen(seg,se);
    end
    bw = seg;
end
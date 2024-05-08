close all
clear
metadata=readtable("metadata.csv");

[im_sin,~,~] = find(metadata.quality==0);
sin = metadata(im_sin,:);
RAN=randi([1,height(sin)]);

im_sin_str = string(sin.image(RAN));
I= imread(im_sin_str);
figure
imshow(I,[])
%% 
red_channel = I(:,:,1);
I1 = de2bi(red_channel);
bit1 = reshape(I1(:,1),size(red_channel));
bit2 = reshape(I1(:,2),size(red_channel));
bit3 = reshape(I1(:,3),size(red_channel));
bit4 = reshape(I1(:,4),size(red_channel));
bit5 = reshape(I1(:,5),size(red_channel));
bit6 = reshape(I1(:,6),size(red_channel));
bit7 = reshape(I1(:,7),size(red_channel));
bit8 = reshape(I1(:,8),size(red_channel));
figure()
subplot(421)
imshow(bit1,[])
subplot(422)
imshow(bit2,[])
subplot(423)
imshow(bit3,[])
subplot(424)
imshow(bit4,[])
subplot(425)
imshow(bit5,[])
subplot(426)
imshow(bit6,[])
subplot(427)
imshow(bit7,[])
subplot(428)
imshow(bit8,[])
label_area = zeros(1,11);
label_circ = zeros(1,11);
se = strel('disk',10,8);
for i = 1:11
    switch i
        case 1
            seg = logical(bit6) & logical(bit7) & logical(bit5) & logical(bit4);
            segclose = imclose(seg,se);
        case 2
            seg = logical(bit6) & logical(bit7) & logical(bit5);
            segclose = imclose(seg,se);
        case 3
            seg = logical(bit6) & logical(bit7) & logical(bit4);
            segclose = imclose(seg,se);
        case 4
            seg = logical(bit7) & logical(bit5) & logical(bit4);
            segclose = imclose(seg,se);
        case 5
            seg = logical(bit6) & logical(bit5) & logical(bit4);
            segclose = imclose(seg,se);
        case 6
            seg = logical(bit6) & logical(bit7);
            segclose = imclose(seg,se);
        case 7
            seg = logical(bit7) & logical(bit5);
            segclose = imclose(seg,se);
        case 8
            seg = logical(bit7) & logical(bit4);
            segclose = imclose(seg,se);
        case 9
            seg = logical(bit6) & logical(bit5);
            segclose = imclose(seg,se);
        case 10
            seg = logical(bit6) & logical(bit4);
            segclose = imclose(seg,se);
        case 11
            seg = logical(bit5) & logical(bit4);
            segclose = imclose(seg,se);
    end
    statsd = regionprops(segclose,'Circularity','Centroid',"Area","BoundingBox","Perimeter");
    dotper = cat(1,statsd.Perimeter);
    dotarea = cat(1,statsd.Circularity);
    dotcirc = cat(1,statsd.Area);
    compcirc=isinf(dotcirc)==0;
    dotcirc=dotcirc.*compcirc;
    dotarea=dotarea.*compcirc;
    dotper=dotper.*compcirc;
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
    end
    [~,idx] = max(dotarea);
    label_circ(i)=dotarea(idx);
    label_area(i)=dotcirc(idx);
    label_per(i)=dotper(idx);
end
ratios = label_circ.*(label_area./label_per);
[~,ratio_idx] = max(ratios);
    switch ratio_idx
        case 1
            seg = logical(bit6) & logical(bit7) & logical(bit5) & logical(bit4);
            segclose = imclose(seg,se);
        case 2
            seg = logical(bit6) & logical(bit7) & logical(bit5);
            segclose = imclose(seg,se);
        case 3
            seg = logical(bit6) & logical(bit7) & logical(bit4);
            segclose = imclose(seg,se);
        case 4
            seg = logical(bit7) & logical(bit5) & logical(bit4);
            segclose = imclose(seg,se);
        case 5
            seg = logical(bit6) & logical(bit5) & logical(bit4);
            segclose = imclose(seg,se);
        case 6
            seg = logical(bit6) & logical(bit7);
            segclose = imclose(seg,se);
        case 7
            seg = logical(bit7) & logical(bit5);
            segclose = imclose(seg,se);
        case 8
            seg = logical(bit7) & logical(bit4);
            segclose = imclose(seg,se);
        case 9
            seg = logical(bit6) & logical(bit5);
            segclose = imclose(seg,se);
        case 10
            seg = logical(bit6) & logical(bit4);
            segclose = imclose(seg,se);
        case 11
            seg = logical(bit5) & logical(bit4);
            segclose = imclose(seg,se);
    end
figure
imshow(segclose);
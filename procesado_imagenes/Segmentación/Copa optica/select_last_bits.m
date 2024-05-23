function bwt = select_last_bits(I,disclogical)
    single_channel = double(I);
    stdsingle = std(single_channel(:));
    single_channel = single_channel - stdsingle;
%     figure
%     imshow(single_channel,[]);
    preproc_single_channel8 = uint8(single_channel);
    adj_preproc = imadjust(preproc_single_channel8);
%     figure
%     imshow(adj_preproc,[])
    I1 = de2bi(adj_preproc);
    bit7 = reshape(I1(:,7),size(single_channel));
    bit8 = reshape(I1(:,8),size(single_channel));
    initbw = logical(bit7) & logical(bit8);
    bw = selectseg(initbw);
    
    statsd = regionprops(bw,'Circularity','Centroid',"Area","BoundingBox","Perimeter","Eccentricity");
%     figure
%     imshow(bw)
%     hold on 
%     plot(statsd.Centroid(1),statsd.Centroid(2),'*')
%     hold off
    

oP = [statsd.Centroid(1), statsd.Centroid(2)];
cP = [height(bw)/2, length(bw)/2];
dispV = cP - oP;

sI = circshift(bw, dispV);

bwr = imrotate(sI, 180, 'bilinear', 'crop');

bwrs = circshift(bwr, -dispV);

bwt= bw | bwrs;

figure;
subplot(1, 3, 1);
imshow(bw);
title('Original Image');

subplot(1, 3, 2);
imshow(bwrs);
title('Rotated Image');

subplot(1, 3, 3);
imshow(bwrt);
title('Restored Image');


end
function bwt = select_last_bits(I,location)
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
    

oP = ceil([statsd.Centroid(1), statsd.Centroid(2)]);
cP = ceil([length(bw)/2, height(bw)/2]);
dispV = cP - oP;
a=20*location; %location debe ser -1 si el medio disco esta en la izquierda y 1 si esta en la derecha
dispV = [dispV(2),dispV(1)+a];

bws = circshift(bw, dispV);

bwr = imrotate(bws, 180, 'bilinear', 'crop');

bwrs = circshift(bwr, -dispV);

bwt= bw | bwrs;
bwt=imfill(bwt,'Holes');

% figure;
% imshow(bw);
% title('Original Image');
% hold on 
% plot(statsd.Centroid(1),statsd.Centroid(2),'*')
% plot(length(bw)/2, height(bw)/2,'*')
% hold off

% figure;
% imshow(bws);
% title('Shifted Image');
% hold on 
% plot(statsd.Centroid(1),statsd.Centroid(2),'*')
% plot(length(bw)/2, height(bw)/2,'*')
% hold off
% 
% figure;
% imshow(bwr);
% title('Rotated Image');
% hold on 
% plot(statsd.Centroid(1),statsd.Centroid(2),'*')
% plot(length(bw)/2, height(bw)/2,'*')
% hold off
% 
% figure;
% imshow(bwrs);
% title('Rotated and shifted Image');
% hold on 
% plot(statsd.Centroid(1),statsd.Centroid(2),'*')
% plot(length(bw)/2, height(bw)/2,'*')
% hold off

% figure;
% imshow(bwt);
% title('Final Image');
% hold on 
% plot(statsd.Centroid(1),statsd.Centroid(2),'*')
% plot(length(bw)/2, height(bw)/2,'*')
% hold off

end
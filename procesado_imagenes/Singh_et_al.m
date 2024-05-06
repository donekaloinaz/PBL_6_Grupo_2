clear; close all; clc;
metadata=readtable("metadata.csv");
I = imread("image_0643.jpg");
figure
imshow(I,[])
%%
red_channel = I(:,:,1);
[r,c] = size(red_channel);
bin = red_channel > 240;
[label,~] = bwlabel(bin,4);
statsd = regionprops(label,'Circularity','Centroid',"Area","BoundingBox");
dotcirc = cat(1,statsd.Circularity);
dotcentr = cat(1,statsd.Centroid);
dotarea = cat(1,statsd.Area);
dotbox = cat(1,statsd.BoundingBox);
dotarea = dotarea/max(dotarea);
L=0;
x = 1;
for i = 1:height(dotarea)
    if dotarea(i) < 0.5
        L(x) = i;
        x = x+1;
    end
end
dotarea(dotarea<0.5) = [];

if L~=0
    dotcentr(L,:) = [];
    dotcirc(L,:) = [];
    dotbox(L,:) = [];
end
[~,idx] = max(dotcirc);
xcoor = round(dotcentr(idx,1));
ycoor = round(dotcentr(idx,2));
figure
imshow(label)
hold on
plot(xcoor,ycoor,'.m','MarkerSize',8);
hold off
%%
radius = round((1/2)*(c/6 + r/4));
disc = strel('disk',radius,8);
mask = zeros(r,c);
x_range = xcoor-(radius-1):xcoor+(radius-1);
y_range = ycoor-(radius-1):ycoor+(radius-1);
mask(y_range,x_range) = disc.getnhood();
figure
imshow(mask);
figure
masked_im = I(:,:,:).*uint8(mask);
imshow(masked_im,[]);
%% 
masked_red_channel = red_channel.*uint8(mask);
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
%% 
seg = logical(bit6) & logical(bit7) & logical(bit8);
figure
imshow(seg);
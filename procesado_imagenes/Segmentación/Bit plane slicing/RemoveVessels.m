function im_sin=RemoveVessels(I)

im_rgb = im2double(I);

im_green = im_rgb(:,:,2);

im_enh = adapthisteq(im_green,'numTiles',[8 8],'nBins',128);

im_gray = imcomplement(im_enh); 

se = strel('disk',10);
im_top = imtophat(im_gray,se);
im_top_8=im2uint8(im_top);
im_top_8=imadjust(im_top_8);


%im_thre=im_top_8>100;
im_thre=imbinarize(im_top_8, 'adaptive');

se = strel('disk',5);
im_thre=imopen(im_thre,se);
se = strel('disk',7);
im_thre=imdilate(im_thre,se);
se = strel('disk',5);
im_thre=imclose(im_thre,se);
im_thre=imclose(im_thre,se);
im_thre=imclose(im_thre,se);

im_sin=inpaintCoherent(I,im_thre,"SmoothingFactor",2,"Radius",10);

end
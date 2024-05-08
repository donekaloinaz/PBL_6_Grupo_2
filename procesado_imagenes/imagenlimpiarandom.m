function I = imagenlimpiarandom(imlimpiaspredict)
RAN=randi([1,length(imlimpiaspredict)]);
im_sin_str = string(imlimpiaspredict(RAN));
I= imread(im_sin_str);
end
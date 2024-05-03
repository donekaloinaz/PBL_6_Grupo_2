clear; close all; clc;
metadata = readtable('metadata.csv');
%% Segmentacion
im_revisadas_qnt = sum(metadata.quality~=0);
[im_revisadas,~,~] = find(metadata.quality~=0);
[im_no_revisadas,~,~] = find(metadata.quality==0);
no_revisadas = metadata(im_no_revisadas,:);
revisadas = metadata(im_revisadas,:);
[im_limpias,~,~] = find(revisadas.quality==4);
[im_malas,~,~] = find(revisadas.quality~=4);
[im_bajocontraste,~,~] = find(revisadas.quality==1);
[im_desenfoque,~,~] = find(revisadas.quality==2);
[im_ruido,~,~] = find(revisadas.quality==3);
%% Mostrar Glaucoma vs No Glaucoma
im_n_str = string(metadata.image(1));
I_n = imread(im_n_str);
im_p_str = string(metadata.image(5));
I_p = imread(im_p_str);
% figure
% subplot(121)
% imshow(I_n); title('Glaucoma negativo');
% subplot(122)
% imshow(I_p); title('Glaucoma positivo');
%% Mostrar tipos de imagenes malas
im_limp_str = string(revisadas.image(im_limpias(3)));
I_limp = imread(im_limp_str);
im_bajocontraste_str = string(revisadas.image(im_bajocontraste(3)));
I_bajocontraste = imread(im_bajocontraste_str);
im_desenfoque_str = string(revisadas.image(im_desenfoque(3)));
I_desenfoque = imread(im_desenfoque_str);
im_ruido_str = string(revisadas.image(im_ruido(3)));
I_ruido = imread(im_ruido_str);
% figure
% subplot(221)
% imshow(I_limp,[]); title('Imagen limpia');
% subplot(222)
% imshow(I_bajocontraste,[]); title('Imagen con bajo contraste');
% subplot(223)
% imshow(I_desenfoque,[]); title('Imagen desenfocada');
% subplot(224)
% imshow(I_ruido,[]); title('Imagen con ruido')
%% Classificación de Calidad
% immse, psnr y ssim despues de filtro mediana, entropy, fft, varianza y brisque
% firstfittable = revisadas_features(revisadas);
% save('firstfittable.mat','firstfittable');
% load firstfittable.mat
% first_model(firstfittable);
% multiclassfittable = revisadas_features_multiclass(revisadas);
% save('multiclassfittable.mat','multiclassfittable');
load multiclassfittable.mat
results = multiclass_model(multiclassfittable);
% no_revisadas_predict = no_revisadas_features(no_revisadas);
% save('no_revisadas_predict.mat','no_revisadas_predict');
[cantidades, nombres, scores] = predictions;
%% Glaucoma detection
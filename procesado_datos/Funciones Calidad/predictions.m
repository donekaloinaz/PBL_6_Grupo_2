function [cantidades, nombres, scores] = predictions
load svm_model_multiclass.mat
load no_revisadas_predict.mat
features = no_revisadas_predict{:,2:end};
[predictions, pscores] = predict(svm_mdl,features);
cantidades = struct();
nombres = struct();
scores = struct();
im_bajocontraste_qnt = 0;
im_bajocontraste_names = string();
im_desenfoque_qnt = 0;
im_desenfoque_names = string();
im_ruido_qnt = 0;
im_ruido_names = string();
im_limpias_qnt = 0;
for i = 1:length(predictions)
    switch predictions(i)
        case 1
            % figure;
            im_str = string(no_revisadas_predict.image(i));
            % I = imread(im_str);
            % imshow(I,[]);
            im_bajocontraste_qnt = im_bajocontraste_qnt + 1;
            im_bajocontraste_names(im_bajocontraste_qnt) = im_str;
            bajocontraste_scores(im_bajocontraste_qnt) = pscores(i);
        case 2
            % figure;
            im_str = string(no_revisadas_predict.image(i));
            % I = imread(im_str);
            % imshow(I,[]);
            im_desenfoque_qnt = im_desenfoque_qnt + 1;
            im_desenfoque_names(im_desenfoque_qnt) = im_str;
            desenfoque_scores(im_desenfoque_qnt) = pscores(i);
        case 3
            % figure;
            im_str = string(no_revisadas_predict.image(i));
            % I = imread(im_str);
            % imshow(I,[]);
            im_ruido_qnt = im_ruido_qnt + 1;
            im_ruido_names(im_ruido_qnt) = im_str;
            ruido_scores(im_ruido_qnt) = pscores(i);
        case 4
            im_str = string(no_revisadas_predict.image(i));
            % figure('Name',im_str)
            % I = imread(im_str);
            % imshow(I,[]);
            im_limpias_qnt = im_limpias_qnt + 1;
            im_limpias_names(im_limpias_qnt) = im_str;
            limpias_scores(im_limpias_qnt) = pscores(i);
    end
end
cantidades.bajocontraste = im_bajocontraste_qnt;
cantidades.desenfoque = im_desenfoque_qnt;
cantidades.ruido = im_ruido_qnt;
cantidades.limpias = im_limpias_qnt;
nombres.bajocontraste = im_bajocontraste_names;
nombres.desenfoque = im_desenfoque_names;
nombres.ruido = im_ruido_names;
nombres.limpias = im_limpias_names;
scores.bajocontraste = bajocontraste_scores;
scores.desenfoque = desenfoque_scores;
scores.ruido = ruido_scores;
scores.limpias = limpias_scores;
% for i = 1:length(predictions)
%     if predictions(i) == 0
%         figure;
%         im_str = string(no_revisadas_predict.image(i));
%         I = imread(im_str);
%         imshow(I,[]);
%     end
% end
end
% de las primeras 100 'image_0082.jpg' and 'image_0092.jgp' se clasifican como buenas pero se ven
% desenfocadas

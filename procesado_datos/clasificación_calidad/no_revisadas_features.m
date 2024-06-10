function tabla_no_revisadas = no_revisadas_features(no_revisadas)
tabla_no_revisadas = table();
tabla_no_revisadas.image = no_revisadas.image;
[immse_vals, psnr_vals, ssim_vals, std_vals, brisque_vals, entropy_vals, entropy_ft_vals] = getiminfo(no_revisadas);
tabla_no_revisadas.immse = immse_vals;
tabla_no_revisadas.psnr = psnr_vals;
tabla_no_revisadas.ssim = ssim_vals;
tabla_no_revisadas.std = std_vals;
tabla_no_revisadas.brisque = brisque_vals;
tabla_no_revisadas.entropy = entropy_vals;
tabla_no_revisadas.ftentropy = entropy_ft_vals;
%%
    function [immse_vals, psnr_vals, ssim_vals, std_vals, brisque_vals, entropy_vals, entropy_ft_vals] = getiminfo(no_revisadas)
        immse_vals = zeros(height(no_revisadas),1);
        psnr_vals = zeros(height(no_revisadas),1);
        ssim_vals = zeros(height(no_revisadas),1);
        std_vals = zeros(height(no_revisadas),1);
        brisque_vals = zeros(height(no_revisadas),1);
        entropy_vals = zeros(height(no_revisadas),1);
        entropy_ft_vals = zeros(height(no_revisadas),1);
        for i = 1:height(no_revisadas)
            imstr = string(no_revisadas.image(i));
            I = imread(imstr);
            Ig = rgb2gray(I);
            filtI = medfilt2(Ig,[5,5]);
            immse_vals(i) = immse(filtI,Ig);
            psnr_vals(i) = psnr(filtI,Ig);
            ssim_vals(i) = ssim(filtI,Ig);
            std_vals(i) = std2(Ig);
            brisque_vals(i) = brisque(Ig);
            entropy_vals(i) = entropy(Ig);
            Ifft = abs(fft(I));
            entropy_ft_vals(i) = entropy(Ifft);
        end
    end
end
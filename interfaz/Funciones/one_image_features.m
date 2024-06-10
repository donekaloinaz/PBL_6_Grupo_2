function Features=one_image_features(I)

Ig = rgb2gray(I);
filtI = medfilt2(Ig,[5,5]);
immse_vals = immse(filtI,Ig);
psnr_vals = psnr(filtI,Ig);
ssim_vals = ssim(filtI,Ig);
std_vals = std2(Ig);
brisque_vals = brisque(Ig);
entropy_vals = entropy(Ig);
Ifft = abs(fft(I));
entropy_ft_vals = entropy(Ifft);
Features = [immse_vals,psnr_vals,ssim_vals,std_vals,brisque_vals,entropy_vals,entropy_ft_vals];
% Features=table();
% Features.immse = immse_vals;
% Features.psnr = psnr_vals;
% Features.ssim = ssim_vals;
% Features.std = std_vals;
% Features.brisque = brisque_vals;
% Features.entropy = entropy_vals;
% Features.ftentropy = entropy_ft_vals;

end
function [psnr_value,ssim_value]=metrics(img, original_img)

% PSNR 

psnr_value = psnr(img,original_img);


% SSIM 

ssim_value = ssim(img, original_img);

end
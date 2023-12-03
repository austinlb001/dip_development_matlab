function [psnr_value,ssim_value,cw_ssim_value,UNIQUE_value,MS_UNIQUE_value,csv_value, SUMMER_value]=metrics(img, original_img)

% 1. PSNR 
% 2. SSIM
% 3. CW-SSIM
% 4. UNIQUE 
% 5. MS-UNIQUE
% 6. CSV
% 7. SUMMER


% image resize 
if size(img,1)~= size(original_img,1)
    img = imresize(img,[size(original_img,1) size(original_img,2)],"cubic");
end


% PSNR 
psnr_value = psnr(img,original_img);

% SSIM 
ssim_value = ssim(img, original_img);

% CW-SSIM
cw_ssim_value = cwssim_index(img, original_img,4,4,0,0);

% UNIQUE
UNIQUE_value = mslUNIQUE(img, original_img);

% MS-UNIQUE
MS_UNIQUE_value = mslMSUNIQUE(img, original_img);

% CSV
csv_value = csv(img, original_img);

% SUMMER
SUMMER_value = SUMMER(original_img,img);

end
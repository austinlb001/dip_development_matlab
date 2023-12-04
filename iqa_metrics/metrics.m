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
    
    % COLOR IMAGES
    if length(size(img)) == 3
        
        % PSNR (GRAYSCALE OR COLOR)
        psnr_value = psnr(img,original_img);
        
        % SSIM (GRAYSCALE OR COLOR)
        ssim_value = ssim(img, original_img);
        
        % UNIQUE (COLOR)
        UNIQUE_value = mslUNIQUE(img, original_img);
        
        % MS-UNIQUE (COLOR)
        MS_UNIQUE_value = mslMSUNIQUE(img, original_img);
        
        % CSV (COLOR)
        csv_value = csv(img, original_img);
        
        % SUMMER (COLOR)
        SUMMER_value = SUMMER(original_img,img);
    
        % CW-SSIM (GRAYSCALE)
        cw_ssim_value = cwssim_index(im2gray(img), im2gray(original_img),1,4,0,0);
    
    % GRAYSCALE IMAGES
    elseif length(size(img)) == 2
        
        % PSNR (GRAYSCALE OR COLOR)
        psnr_value = psnr(img,original_img);
        
        % SSIM (GRAYSCALE OR COLOR)
        ssim_value = ssim(img, original_img);
    
        % CW-SSIM (GRAYSCALE)
        cw_ssim_value = cwssim_index(img, original_img,1,4,0,0);
        
        % UNIQUE (COLOR)
        img = cat(3, img, img, img);
        original_img = cat(3, original_img, original_img, original_img);
        UNIQUE_value = mslUNIQUE(img, original_img);
        
        % MS-UNIQUE (COLOR)
        MS_UNIQUE_value = mslMSUNIQUE(img, original_img);
        
        % CSV (COLOR)
        csv_value = csv(img, original_img);
        
        % SUMMER (COLOR)
        SUMMER_value = SUMMER(original_img,img);   
    end
end

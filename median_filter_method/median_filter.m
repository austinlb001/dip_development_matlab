% AUTHORS: BARBER, AUSTIN L; DUFFY-DENO, CAITRIN
% FILE NAME: median.m
% DATE CREATED: 2023 NOVEMBER 30
% DATE LAST UPDATED: 2023 NOVEMBER 30
% PURPOSE: THIS FILE CONTAINS THE CODE FOR APPLYING A MEDIAN FILTER.


%%%%%%%%%%%%%%% F U N C T I O N S %%%%%%%%%%%%%%%

% NAME: median
% TYPE: FUNCTION
% PARAMETERS: file_paths: list, no_challenge_image: np.ndarray
% RETURN: array
% PURPOSE: FUNCTION FOR APPLYING THE MEDIAN FILTER ON A SET IMAGES.
% NOTES: 
function median_filt_img = median_filter(image, kernel_dim, padding_type)
    
    % HANDLE GRAYSCALE AND COLOR IMAGES
    median_filt_img = zeros(size(image));
    if length(size(image)) == 2
        median_filt_img = medfilt2(image, [kernel_dim, kernel_dim], padding_type);
    elseif length(size(image)) == 3
        median_filt_img = medfilt3(image, [kernel_dim, kernel_dim, kernel_dim], padding_type);
    end

end

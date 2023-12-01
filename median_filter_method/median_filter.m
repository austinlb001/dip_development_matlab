% AUTHORS: BARBER, AUSTIN L; DUFFY-DENO, CAITRIN
% FILE NAME: median_filter.m
% DATE CREATED: 2023 NOVEMBER 30
% DATE LAST UPDATED: 2023 NOVEMBER 30
% PURPOSE: THIS FILE CONTAINS THE CODE FOR GETTING THE MEDIAN FILTER


%%%%%%%%%%%%%%% F U N C T I O N S %%%%%%%%%%%%%%%

% NAME: median
% TYPE: FUNCTION
% PARAMETERS: file_paths: list, no_challenge_image: np.ndarray
% RETURN: list
% PURPOSE: FUNCTION FOR APPLYING THE MEDIAN FILTER ON A SET IMAGES.
% NOTES: 
function median_filt_img = median_filter(array, kernel_dim, padding_type)
    
    % HANDLE GRAYSCALE AND COLOR IMAGES
    median_filt_img = zeros(size(array));
    if length(size(array)) == 2
        median_filt_img = medfilt2(array, [kernel_dim, kernel_dim], padding_type);
    elseif length(size(array)) == 3
        median_filt_img = medfilt3(array, [kernel_dim, kernel_dim, kernel_dim], padding_type);
    end

end

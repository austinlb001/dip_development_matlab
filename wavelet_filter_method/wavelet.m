% AUTHORS: BARBER, AUSTIN L; DUFFY-DENO, CAITRIN
% FILE NAME: wavelet.m
% DATE CREATED: 2023 NOVEMBER 30
% DATE LAST UPDATED: 2023 NOVEMBER 30
% PURPOSE: THIS FILE CONTAINS THE CODE FOR APPLYING A WAVELET FILTER.


%%%%%%%%%%%%%%% F U N C T I O N S %%%%%%%%%%%%%%%

% NAME: wavelet
% TYPE: FUNCTION
% PARAMETERS: file_paths: list, no_challenge_image: np.ndarray
% RETURN: array
% PURPOSE: FUNCTION FOR APPLYING THE MEDIAN FILTER ON A SET IMAGES.
% NOTES: 
function wavelet_filt_img = wavelet(image, wavelet_type)
        
    % FIND THE MAXIMUM LEVEL
    levels = wmaxlev(size(image), wavelet_type);
        
    % HANDLE COLOR CASE
    if length(size(image)) == 2 % GRAYSCALEZ
        
        % CALCULATE WAVELET TRANSFORM
        wavelet_filt_img = wdenoise(double(image)/255.0, levels, Wavelet = wavelet_type, ...
            DenoisingMethod = "UniversalThreshold", ...
            ThresholdRule = "Soft", ...
            NoiseEstimate = "LevelIndependent");

    else
        parfor i = 1:1:length(size(image))
            wavelet_filt_img(:, :, i) = wdenoise(double(image(:, :, i))/255.0, ...
                levels, Wavelet = wavelet_type, ...
                DenoisingMethod = "UniversalThreshold", ...
                ThresholdRule = "Soft", ...
                NoiseEstimate = "LevelIndependent");
        end
    end       
end

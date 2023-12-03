% AUTHORS: BARBER, AUSTIN L; DUFFY-DENO, CAITRIN
% FILE NAME: main.m
% DATE CREATED: 2023 NOVEMBER 30
% DATE LAST UPDATED: 2023 NOVEMBER 30
% PURPOSE: THIS IS THE FILE THAT CONTAINS THE MAIN CODE

% CLEAR ALL
%clear all;

% CLOSE ALL OPEN MATLAB WINDOWS
close all;

% CLEAR MATLAB COMMAND WINDOW
clc;

%%%%%%%%%%%%%%% A D D  P A T H S %%%%%%%%%%%%%%%
addpath database/
addpath iqa_metrics/
addpath median_filter_method/
addpath wavelet_filter_method/
pool = parpool('Processes', 12);
addAttachedFiles(pool, '/home/austinlb001/MATLAB Add-Ons/');
addAttachedFiles(pool, 'iqa_metrics/');
addAttachedFiles(pool, 'median_filter_method/');
addAttachedFiles(pool, 'wavelet_filter_method/');

%%%%%%%%%%%%%%% M A I N %%%%%%%%%%%%%%%

%% CURE - OR

% generate file paths that are grouped by unique image scene
 grouped_dir = datasets_reading.cure_or_paths;
 
% CREATE BASELINE TABLE
store_CURE_OR_baseline = cell2table({'00', '00','00' , '00', '00', '00', 0,0,0,0,0,0, 0});
store_CURE_OR_baseline.Properties.VariableNames = ["Background", "DeviceID", "Object Orientation", "Object ID", "Challenge Type", "Challenge Level", "PSNR", "SSIM", "CW-SSIM", "UNIQUE", "MS-UNIQUE","CSV","SUMMER"];

% CREATE MEDIAN FILTER TABLE
store_CURE_OR_median = cell2table({'00', '00','00' , '00', '00', '00', 0,0,0,0,0,0, 0});
store_CURE_OR_median.Properties.VariableNames = ["Background", "DeviceID", "Object Orientation", "Object ID", "Challenge Type", "Challenge Level", "PSNR", "SSIM", "CW-SSIM", "UNIQUE", "MS-UNIQUE","CSV","SUMMER"];

% CREATE BASELINE TABLE
store_CURE_OR_wavelet = cell2table({'00', '00','00' , '00', '00', '00', 0,0,0,0,0,0, 0});
store_CURE_OR_wavelet.Properties.VariableNames = ["Background", "DeviceID", "Object Orientation", "Object ID", "Challenge Type", "Challenge Level", "PSNR", "SSIM", "CW-SSIM", "UNIQUE", "MS-UNIQUE","CSV","SUMMER"];

% iterate through groups 
parfor ii = 1:length(grouped_dir)
    disp(ii)
    for jj = 1:length(grouped_dir{1,ii})
        
        % Find original/ no challenge image 
        
        current_group = grouped_dir{1,ii}{1,jj};
        challenge_check=contains(current_group,'no_challenge');
        no_challenge_img_idx = find(challenge_check); 

        % no challenge image path
        no_challenge_img_path = current_group(no_challenge_img_idx); 
        no_challenge_img = imread(no_challenge_img_path{1});

        % Challenge images 
        current_group(no_challenge_img_idx)=[];


        for challenge = 1:length(current_group)
            current_img_path = current_group(challenge);
            current_img = imread(current_img_path{1});

            % MEDIAN FILTER
            median_filt_img = median_filter(current_img,7,'symmetric');

            % WAVELET FILTER 
            wavelet_filt_img = wavelet_filter(current_img, 'haar');

            % CALCULATE BASELINE METRICS
            [psnr_value_baseline,ssim_value_baseline,cw_ssim_value_baseline,...
                UNIQUE_value_baseline,MS_UNIQUE_value_baseline,...
                csv_value_baseline,SUMMER_value_baseline] = metrics(current_img,no_challenge_img);

            % CALCULATE MEDIAN FILTERED METRICS
            [psnr_value_median,ssim_value_median,cw_ssim_value_median,...
                UNIQUE_value_median,MS_UNIQUE_value_median,...
                csv_value_median,SUMMER_value_median] = metrics(median_filt_img,no_challenge_img);

            % CALCULATE MEDIAN FILTERED METRICS
            [psnr_value_wavelet,ssim_value_wavelet,cw_ssim_value_wavelet,...
                UNIQUE_value_wavelet,MS_UNIQUE_value_wavelet,...
                csv_value_wavelet,SUMMER_value_wavelet] = metrics(wavelet_filt_img,no_challenge_img);

            % Metadata extract 
            [~,name,~] = fileparts(current_group(challenge));

            file_split = split(name,'_');
            
            background = file_split{1};
            device = file_split{2};
            objOri = file_split{3};
            objID = file_split{4};
            chType = file_split{5};
            chLev = file_split{6};

            % UPDATE BASELINE TABLE 
            new_row = {background, device, objOri, objID, chType, chLev,...
                psnr_value_baseline,ssim_value_baseline,cw_ssim_value_baseline,...
                UNIQUE_value_baseline,MS_UNIQUE_value_baseline,...
                csv_value_baseline, SUMMER_value_baseline};
            store_CURE_OR_baseline = [store_CURE_OR_baseline;new_row];

            % UPDATE MEDIAN TABLE 
            new_row = {background, device, objOri, objID, chType, chLev,...
                psnr_value_median,ssim_value_median,cw_ssim_value_median,...
                UNIQUE_value_median,MS_UNIQUE_value_median,...
                csv_value_median, SUMMER_value_median};
            store_CURE_OR_median = [store_CURE_OR_median;new_row];

            % UPDATE WAVELET TABLE 
            new_row = {background, device, objOri, objID, chType, chLev,...
                psnr_value_wavelet,ssim_value_wavelet,cw_ssim_value_wavelet,...
                UNIQUE_value_wavelet,MS_UNIQUE_value_wavelet,...
                csv_value_wavelet, SUMMER_value_wavelet};
            store_CURE_OR_wavelet = [store_CURE_OR_wavelet;new_row];
        end 
    end 
end

% WRITE TABLE TO EXCEL SPREADSHEET
writetable(store_CURE_OR_baseline, "cure-or.xlsx", "Sheet", "Baseline", "Range", "A1");

% WRITE TABLE TO EXCEL SPREADSHEET
writetable(store_CURE_OR_median, "cure-or.xlsx", "Sheet", "Median", "Range", "A1");

% WRITE TABLE TO EXCEL SPREADSHEET
writetable(store_CURE_OR_wavelet, "cure-or.xlsx", "Sheet", "Wavelet", "Range", "A1");


%% CURE - TSR 


% generate file paths that are grouped by unique image scene
grouped_dir = datasets_reading.cure_tsr_paths;

% CREATE BASELINE TABLE
store_CURE_TSR_baseline = cell2table({'00', '00','00' , '00', '00', '00', 0,0,0,0,0,0, 0});
store_CURE_TSR_baseline.Properties.VariableNames = ["Background", "DeviceID", "Object Orientation", "Object ID", "Challenge Type", "Challenge Level", "PSNR", "SSIM", "CW-SSIM", "UNIQUE", "MS-UNIQUE","CSV","SUMMER"];

% CREATE MEDIAN FILTER TABLE
store_CURE_TSR_median = cell2table({'00', '00','00' , '00', '00', '00', 0,0,0,0,0,0, 0});
store_CURE_TSR_median.Properties.VariableNames = ["Background", "DeviceID", "Object Orientation", "Object ID", "Challenge Type", "Challenge Level", "PSNR", "SSIM", "CW-SSIM", "UNIQUE", "MS-UNIQUE","CSV","SUMMER"];

% CREATE BASELINE TABLE
store_CURE_TSR_wavelet = cell2table({'00', '00','00' , '00', '00', '00', 0,0,0,0,0,0, 0});
store_CURE_TSR_wavelet.Properties.VariableNames = ["Background", "DeviceID", "Object Orientation", "Object ID", "Challenge Type", "Challenge Level", "PSNR", "SSIM", "CW-SSIM", "UNIQUE", "MS-UNIQUE","CSV","SUMMER"];

% iterate through groups 
for ii = 1:length(grouped_dir)
    for jj = 1:length(grouped_dir{1,ii})
        disp(ii)
        % Find original/ no challenge image 
        current_group = grouped_dir{1,ii}{1,jj};

        challenge_check=contains(current_group,'no_challenge');

        no_challenge_img_idx = find(challenge_check); 

        % no challenge image path
        no_challenge_img_path = current_group(no_challenge_img_idx); 
        no_challenge_img = imread(no_challenge_img_path{1});

        % Challenge images 
        current_group(no_challenge_img_idx)=[];
        for challenge = 1:length(current_group)
            current_img_path = current_group(challenge);
            current_img = imread(current_img_path{1});

            % MEDIAN FILTER
            median_filt_img = median_filter(current_img,7,'symmetric');

            % WAVELET FILTER 
            wavelet_filt_img = wavelet_filter(current_img, 'haar');

            % CALCULATE BASELINE METRICS
            [psnr_value_baseline,ssim_value_baseline,cw_ssim_value_baseline,...
                UNIQUE_value_baseline,MS_UNIQUE_value_baseline,...
                csv_value_baseline,SUMMER_value_baseline] = metrics(current_img,no_challenge_img);

            % CALCULATE MEDIAN FILTERED METRICS
            [psnr_value_median,ssim_value_median,cw_ssim_value_median,...
                UNIQUE_value_median,MS_UNIQUE_value_median,...
                csv_value_median,SUMMER_value_median] = metrics(median_filt_img,no_challenge_img);

            % CALCULATE MEDIAN FILTERED METRICS
            [psnr_value_wavelet,ssim_value_wavelet,cw_ssim_value_wavelet,...
                UNIQUE_value_wavelet,MS_UNIQUE_value_wavelet,...
                csv_value_wavelet,SUMMER_value_wavelet] = metrics(wavelet_filt_img,no_challenge_img);
            

            % Metadata extract 
            [~,name,~] = fileparts(current_group(challenge));

            file_split = split(name,'_');
            
            background = file_split{1};
            device = file_split{2};
            objOri = file_split{3};
            objID = file_split{4};
            chType = file_split{5};
            chLev = file_split{6};

            % UPDATE BASELINE TABLE 
            new_row = {background, device, objOri, objID, chType, chLev,...
                psnr_value_baseline,ssim_value_baseline,cw_ssim_value_baseline,...
                UNIQUE_value_baseline,MS_UNIQUE_value_baseline,...
                csv_value_baseline, SUMMER_value_baseline};
            store_CURE_TSR_baseline = [store_CURE_OR_baseline;new_row];

            % UPDATE MEDIAN TABLE 
            new_row = {background, device, objOri, objID, chType, chLev,...
                psnr_value_median,ssim_value_median,cw_ssim_value_median,...
                UNIQUE_value_median,MS_UNIQUE_value_median,...
                csv_value_median, SUMMER_value_median};
            store_CURE_TSR_median = [store_CURE_OR_median;new_row];

            % UPDATE WAVELET TABLE 
            new_row = {background, device, objOri, objID, chType, chLev,...
                psnr_value_wavelet,ssim_value_wavelet,cw_ssim_value_wavelet,...
                UNIQUE_value_wavelet,MS_UNIQUE_value_wavelet,...
                csv_value_wavelet, SUMMER_value_wavelet};
            store_CURE_TSR_wavelet = [store_CURE_OR_wavelet;new_row];
        end              
    end 
end

% WRITE TABLE TO EXCEL SPREADSHEET
writetable(store_CURE_TSR_baseline, "cure-tsr.xlsx", "Sheet", "Baseline", "Range", "A1");

% WRITE TABLE TO EXCEL SPREADSHEET
writetable(store_CURE_TSR_median, "cure-tsr.xlsx", "Sheet", "Median", "Range", "A1");

% WRITE TABLE TO EXCEL SPREADSHEET
writetable(store_CURE_TSR_median, "cure-tsr.xlsx", "Sheet", "Wavelet", "Range", "A1");

%% CURE - TSD 

grouped_dir = datasets_reading.cure_tsd_paths;

 


% AUTHORS: BARBER, AUSTIN L; DUFFY-DENO, CAITRIN
% FILE NAME: main.m
% DATE CREATED: 2023 NOVEMBER 30
% DATE LAST UPDATED: 2023 NOVEMBER 30
% PURPOSE: THIS IS THE FILE THAT CONTAINS THE MAIN CODE

% CLEAR ALL
clear all;

% CLOSE ALL OPEN MATLAB WINDOWS
close all;

% CLEAR MATLAB COMMAND WINDOW
clc;

%%%%%%%%%%%%%%% A D D  P A T H S %%%%%%%%%%%%%%%
addpath database/
addpath iqa_metrics/
addpath iqa_metrics/CSV/Code/
addpath iqa_metrics/MS-UNIQUE/
addpath iqa_metrics/SUMMER/Code/
addpath iqa_metrics/UNIQUE-Unsupervised-Image-Quality-Estimation/
addpath median_filter_method/
addpath wavelet_filter_method/


%%%%%%%%%%%%%%% M A I N %%%%%%%%%%%%%%%

%% CURE - OR

% generate file paths that are grouped by unique image scene
 grouped_dir = datasets_reading.cure_or_paths;
 

% Create table 
store_CURE_OR = cell2table({'00', '00','00' , '00', '00', '00', 0,0,0,0,0,0, 0});
store_CURE_OR.Properties.VariableNames = ["Background", "DeviceID", "Object Orientation", "Object ID", "Challenge Type", "Challenge Level", "PSNR", "SSIM", "CW-SSIM", "UNIQUE", "MS-UNIQUE","CSV","SUMMER"];
            
% iterate through groups 
parfor ii = 1:length(grouped_dir)
    disp(ii)
    for jj = 1:length(grouped_dir{1,1})
        
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

            % Median filter
            %median_filt_img = median_filter(current_img,7,'zeros');

            % Wavelet filter 


            % Metrics calculated 
            [psnr_value,ssim_value,cw_ssim_value,UNIQUE_value,MS_UNIQUE_value,csv_value, SUMMER_value] = metrics(current_img,no_challenge_img);
            

            % Metadata extract 
            [~,name,~] = fileparts(current_group(challenge));

            file_split = split(name,'_');
            
            background = file_split{1};
            device = file_split{2};
            objOri = file_split{3};
            objID = file_split{4};
            chType = file_split{5};
            chLev = file_split{6};

            % Update table 
            new = {background, device, objOri, objID, chType, chLev, psnr_value,ssim_value,cw_ssim_value,UNIQUE_value,MS_UNIQUE_value,csv_value, SUMMER_value};
            store_CURE_OR = [store_CURE_OR;new];
        end 
    end 
end

% WRITE TABLE TO EXCEL SPREADSHEET
writetable(store_CURE_OR, "cure-or_baseline.xlsx", "Rang", "A1");


%% CURE - TSR 


% generate file paths that are grouped by unique image scene
 grouped_dir = datasets_reading.cure_tsr_paths;

% iterate through groups 

for ii = 1 %:length(grouped_dir)
    for jj = 1:2 % length(grouped_dir{1,1})
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

            % Median filter
            median_filt_img = median_filter(current_img,7,'zeros');

            % Wavelet filter 


            % Metrics calculated 
            [psnr_value,ssim_value,cw_ssim_value,UNIQUE_value,MS_UNIQUE_value,csv_value, SUMMER_value] = metrics(current_img,no_challenge_img);
            

            % Metadata extract 
            [~,name,~] = fileparts(current_group(challenge));

            file_split = split(name,'_');
            
            background = file_split{1};
            device = file_split{2};
            objOri = file_split{3};
            objID = file_split{4};
            chType = file_split{5};
            chLev = file_split{6};

            % Update table 
            if ~exist('store_CURE_TSR')
                store_CURE_TSR = cell2table({background, device, objOri, objID, chType, chLev, psnr_value,ssim_value,cw_ssim_value,UNIQUE_value,MS_UNIQUE_value,csv_value, SUMMER_value});
                store_CURE_TSR.Properties.VariableNames = ["Background", "DeviceID", "Object Orientation", "Object ID", "Challenge Type", "Challenge Level", "PSNR", "SSIM", "CW-SSIM", "UNIQUE", "MS-UNIQUE","CSV","SUMMER"];
            else
                new = {background, device, objOri, objID, chType, chLev, psnr_value,ssim_value,cw_ssim_value,UNIQUE_value,MS_UNIQUE_value,csv_value, SUMMER_value};
                store_CURE_TSR = [store_CURE_TSR;new];
            end 
        end              
    end 
end

%% CURE - TSD 

grouped_dir = datasets_reading.cure_tsd_paths;

 


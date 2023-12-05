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
addpath iqa_metrics/CSV/Code/FastEMD/
addpath '/home/austinlb001/MATLAB Add-Ons/'
addpath '/home/austinlb001/MATLAB Add-Ons/Collections/matlabPyrTools/'
addpath '/home/austinlb001/MATLAB Add-Ons/Collections/matlabPyrTools/MEX/'
addpath '/home/austinlb001/MATLAB Add-Ons/Functions/Complex-Wavelet Structural Similarity Index (CW-SSIM)/'
addpath iqa_metrics/MS-UNIQUE/
addpath iqa_metrics/MS-UNIQUE/InputWeights/
addpath iqa_metrics/SUMMER/Code/
addpath iqa_metrics/UNIQUE-Unsupervised-Image-Quality-Estimation/
addpath iqa_metrics/UNIQUE-Unsupervised-Image-Quality-Estimation/InputWeights/
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

%%

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
for ii = 7:length(grouped_dir)
    disp(ii)
    for jj = 1:40:length(grouped_dir{1,ii})
        
        % Find original/ no challenge image 
        current_group = grouped_dir{1,ii}{1,jj};
        challenge_check=contains(current_group,'no_challenge');
        no_challenge_img_idx = find(challenge_check);

        % no challenge image path
        no_challenge_img_path = current_group(no_challenge_img_idx);
        no_challenge_img = imread(no_challenge_img_path{1});

        % Challenge images
        current_group(no_challenge_img_idx)=[];


        for challenge = 1:5:length(current_group)
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

% SAVE WORKSPACE
save("cure_or_workspace.mat");

%% CURE - TSR

% generate file paths that are grouped by unique image scene
grouped_dir = datasets_reading.cure_tsr_paths;

%%

grouped_dir = file_storage;
% CREATE BASELINE TABLE
store_CURE_TSR_baseline = cell2table({'00', '00','00' , '00', '0000', 0,0,0,0,0,0,0});
store_CURE_TSR_baseline.Properties.VariableNames = ["Sequence Type", "Sign Type", "Challenge Type", "Challenge Level", "Index", "PSNR", "SSIM", "CW-SSIM", "UNIQUE", "MS-UNIQUE","CSV","SUMMER"];

% CREATE MEDIAN FILTER TABLE
store_CURE_TSR_median = cell2table({'00', '00','00' , '00', '0000', 0,0,0,0,0,0,0});
store_CURE_TSR_median.Properties.VariableNames = ["Sequence Type", "Sign Type", "Challenge Type", "Challenge Level", "Index", "PSNR", "SSIM", "CW-SSIM", "UNIQUE", "MS-UNIQUE","CSV","SUMMER"];
% CREATE BASELINE TABLE
store_CURE_TSR_wavelet = cell2table({'00', '00','00' , '00', '0000',0,0,0,0,0,0, 0});
store_CURE_TSR_wavelet.Properties.VariableNames = ["Sequence Type", "Sign Type", "Challenge Type", "Challenge Level", "Index", "PSNR", "SSIM", "CW-SSIM", "UNIQUE", "MS-UNIQUE","CSV","SUMMER"];

% ppm = ParforProgressbar(length(current_group),'showWorkerProgress',true) %'parpool', {'local', 4});
% 
% pauseTime = 60/1200;

tic
% iterate through groups 
parfor ii = 1:13%:length(grouped_dir)
    for jj = 1:118:length(grouped_dir{1,ii})
        % Find original/ no challenge image
        current_group = grouped_dir{1,ii}{1,jj};

        challenge_check=contains(current_group,'ChallengeFree');

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

            sequence = file_split{1};
            signType = file_split{2};
            chType = file_split{3};
            chLev = file_split{4};
            Index = file_split{5};
            
            % UPDATE BASELINE TABLE
            new_row = {sequence,signType,chType,chLev,Index,...
                psnr_value_baseline,ssim_value_baseline,cw_ssim_value_baseline,...
                UNIQUE_value_baseline,MS_UNIQUE_value_baseline,...
                csv_value_baseline, SUMMER_value_baseline};
            store_CURE_TSR_baseline = [store_CURE_TSR_baseline;new_row];

            % UPDATE MEDIAN TABLE
            new_row = {sequence,signType,chType,chLev,Index,...
                psnr_value_median,ssim_value_median,cw_ssim_value_median,...
                UNIQUE_value_median,MS_UNIQUE_value_median,...
                csv_value_median, SUMMER_value_median};
            store_CURE_TSR_median = [store_CURE_TSR_median;new_row];

            % UPDATE WAVELET TABLE
            new_row = {sequence,signType,chType,chLev,Index,...
                psnr_value_wavelet,ssim_value_wavelet,cw_ssim_value_wavelet,...
                UNIQUE_value_wavelet,MS_UNIQUE_value_wavelet,...
                csv_value_wavelet, SUMMER_value_wavelet};
            store_CURE_TSR_wavelet = [store_CURE_TSR_wavelet;new_row];
        
        end              
    end 


end
toc
% WRITE TABLE TO EXCEL SPREADSHEET
writetable(store_CURE_TSR_baseline, "cure-tsr.xlsx", "Sheet", "Baseline", "Range", "A1");

% WRITE TABLE TO EXCEL SPREADSHEET
writetable(store_CURE_TSR_median, "cure-tsr.xlsx", "Sheet", "Median", "Range", "A1");

% WRITE TABLE TO EXCEL SPREADSHEET
writetable(store_CURE_TSR_wavelet, "cure-tsr.xlsx", "Sheet", "Wavelet", "Range", "A1");

% SAVE WORKSPACE
save("cure_tsr_workspace.mat");

%% CURE - TSD

% generate file paths that are grouped by unique image scene
grouped_dir = datasets_reading.cure_tsd_paths;

%%

% CREATE BASELINE TABLE
store_CURE_TSD_baseline = cell2table({'00', '00', '00' , '00','00', 0,0,0,0,0,0, 0});
store_CURE_TSD_baseline.Properties.VariableNames = ["Sequence Type", "Sequence Number", "Challenge Source Type", "Challenge Type", "Challenge Level", "PSNR", "SSIM", "CW-SSIM", "UNIQUE", "MS-UNIQUE","CSV","SUMMER"];

% CREATE MEDIAN FILTER TABLE
store_CURE_TSD_median = cell2table({'00', '00','00' , '00', '00', 0,0,0,0,0,0, 0});
store_CURE_TSD_median.Properties.VariableNames = ["Sequence Type", "Sequence Number", "Challenge Source Type", "Challenge Type", "Challenge Level", "PSNR", "SSIM", "CW-SSIM", "UNIQUE", "MS-UNIQUE","CSV","SUMMER"];

% CREATE BASELINE TABLE
store_CURE_TSD_wavelet = cell2table({'00', '00','00' , '00', '00',0,0,0,0,0,0, 0});
store_CURE_TSD_wavelet.Properties.VariableNames = ["Sequence Type", "Sequence Number", "Challenge Source Type", "Challenge Type", "Challenge Level", "PSNR", "SSIM", "CW-SSIM", "UNIQUE", "MS-UNIQUE","CSV","SUMMER"];

for ii = 1:length(grouped_dir)
    for jj = 1:10:length(grouped_dir{1,ii})

        % Find original/ no challenge image
        current_group = grouped_dir{1,ii}{1,jj};
        challenge_check=contains(current_group,'_00_00_00');
        no_challenge_img_idx = find(challenge_check);

        % no challenge image path
        no_challenge_img_path = current_group(no_challenge_img_idx);
        no_challenge_vid = VideoReader(no_challenge_img_path{1});

        % Extract every 20th frame and store in image matrix
        frame_count = 300;
        frames_read = 1: 20 : frame_count;
        for k = 1:length(frames_read)
            current_frame = read(no_challenge_vid,frames_read(k));
            no_challenge_images(:,:,:,k) = squeeze(current_frame);            
        end

        
        % Challenge images
        current_group(no_challenge_img_idx)=[];
        for challenge = 1:20:length(current_group)
            current_vid_path = current_group(challenge);
            current_vid = VideoReader(current_vid_path{1});

            %Extract every 20th frame and store in image matrix 
            frame_count = current_vid.NumFrames;
            frames_read = 1:20: frame_count;
            for k = 1:length(frames_read)
                current_frame = read(current_vid,frames_read(k));
                current_img = squeeze(current_frame);
                                   
                % MEDIAN FILTER
                median_filt_img = median_filter(current_img,7,'symmetric');
    
                % WAVELET FILTER
                wavelet_filt_img = wavelet_filter(current_img, 'haar');
    
                % CALCULATE BASELINE METRICS
                [psnr_value_baseline,ssim_value_baseline,cw_ssim_value_baseline,...
                    UNIQUE_value_baseline,MS_UNIQUE_value_baseline,...
                    csv_value_baseline,SUMMER_value_baseline] = metrics(current_img,no_challenge_images(:,:,:,k));
    
                % CALCULATE MEDIAN FILTERED METRICS
                [psnr_value_median,ssim_value_median,cw_ssim_value_median,...
                    UNIQUE_value_median,MS_UNIQUE_value_median,...
                    csv_value_median,SUMMER_value_median] = metrics(median_filt_img,no_challenge_images(:,:,:,k));
    
                % CALCULATE MEDIAN FILTERED METRICS
                [psnr_value_wavelet,ssim_value_wavelet,cw_ssim_value_wavelet,...
                    UNIQUE_value_wavelet,MS_UNIQUE_value_wavelet,...
                    csv_value_wavelet,SUMMER_value_wavelet] = metrics(wavelet_filt_img,no_challenge_images(:,:,:,k));
    
                % Metadata extract
                [~,name,~] = fileparts(current_group(challenge));
    
                file_split = split(name,'_');
    
                sequenceType = file_split{1};
                sequenceNumber = file_split{2};
                chSrcType = file_split{3};
                chType = file_split{4};
                chLev = file_split{5};
    
                % UPDATE BASELINE TABLE
                new_row = {sequenceType, sequenceNumber, chSrcType, chType, chLev,...
                    psnr_value_baseline,ssim_value_baseline,cw_ssim_value_baseline,...
                    UNIQUE_value_baseline,MS_UNIQUE_value_baseline,...
                    csv_value_baseline, SUMMER_value_baseline};
                store_CURE_TSD_baseline = [store_CURE_TSD_baseline;new_row];
    
                % UPDATE MEDIAN TABLE
                new_row = {sequenceType, sequenceNumber, chSrcType, chType, chLev,...
                    psnr_value_median,ssim_value_median,cw_ssim_value_median,...
                    UNIQUE_value_median,MS_UNIQUE_value_median,...
                    csv_value_median, SUMMER_value_median};
                store_CURE_TSD_median = [store_CURE_TSD_median;new_row];
    
                % UPDATE WAVELET TABLE
                new_row = {sequenceType, sequenceNumber, chSrcType, chType, chLev,...
                    psnr_value_wavelet,ssim_value_wavelet,cw_ssim_value_wavelet,...
                    UNIQUE_value_wavelet,MS_UNIQUE_value_wavelet,...
                    csv_value_wavelet, SUMMER_value_wavelet};
                store_CURE_TSD_wavelet = [store_CURE_TSD_wavelet;new_row];
            end 
        end
    end
end

% WRITE TABLE TO EXCEL SPREADSHEET
writetable(store_CURE_TSD_baseline, "cure-tsd.xlsx", "Sheet", "Baseline", "Range", "A1");

% WRITE TABLE TO EXCEL SPREADSHEET
writetable(store_CURE_TSD_median, "cure-tsd.xlsx", "Sheet", "Median", "Range", "A1");

% WRITE TABLE TO EXCEL SPREADSHEET
writetable(store_CURE_TSD_wavelet, "cure-tsd.xlsx", "Sheet", "Wavelet", "Range", "A1");

% SAVE WORKSPACE
save("cure_tsd_workspace.mat");

%% CURE - SIDD

% generate file paths that are grouped by unique image scene
grouped_dir = datasets_reading.sidd_paths;

%%

% CREATE BASELINE TABLE
store_sidd_baseline = cell2table({'00', '00','00' , '00', '00', '00', '00', 0,0,0,0,0,0, 0});
store_sidd_baseline.Properties.VariableNames = ["Scene Instance", "Scene Number", "Phone Code", "ISO Level", "Shutter Speed", "Illuminant Temp.","Illuminant Brightness", "PSNR", "SSIM", "CW-SSIM", "UNIQUE", "MS-UNIQUE","CSV","SUMMER"];

% CREATE MEDIAN FILTER TABLE
store_sidd_median = cell2table({'00', '00','00' , '00', '00', '00', '00', 0,0,0,0,0,0, 0});
store_sidd_median.Properties.VariableNames = ["Scene Instance", "Scene Number", "Phone Code", "ISO Level", "Shutter Speed", "Illuminant Temp.","Illuminant Brightness", "PSNR", "SSIM", "CW-SSIM", "UNIQUE", "MS-UNIQUE","CSV","SUMMER"];

% CREATE BASELINE TABLE
store_sidd_wavelet = cell2table({'00', '00','00' , '00', '00', '00', '00', 0,0,0,0,0,0, 0});
store_sidd_wavelet.Properties.VariableNames = ["Scene Instance", "Scene Number", "Phone Code", "ISO Level", "Shutter Speed", "Illuminant Temp.","Illuminant Brightness", "PSNR", "SSIM", "CW-SSIM", "UNIQUE", "MS-UNIQUE","CSV","SUMMER"];

% iterate through groups
parfor ii = 1:length(grouped_dir)
    disp(ii)
    for jj = 1:1:length(grouped_dir{1,ii})
        
        % Find original/ no challenge image 
        current_group = grouped_dir{1,ii}{1,jj};
        challenge_check = ~contains(current_group,'NOISY_');
        no_challenge_img_idx = find(challenge_check);

        % no challenge image path
        no_challenge_img_path = current_group(no_challenge_img_idx);
        no_challenge_img = imread(no_challenge_img_path{1});

        % Challenge images
        current_group(no_challenge_img_idx)=[];


        for challenge = 1:1:length(current_group)
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
            [name,~,~] = fileparts(current_group(challenge));

            file_split = split(name,'/');
            file_split = split(file_split{6}, '_');

            scene_instance = file_split{1};
            scene = file_split{2};
            phone_code = file_split{3};
            iso_level = file_split{4};
            shutter_speed = file_split{5};
            illum_temp = file_split{6};
            illum_bright = file_split{7};

            % UPDATE BASELINE TABLE
            new_row = {scene_instance, scene, phone_code, iso_level, shutter_speed, illum_temp,illum_bright,...
                psnr_value_baseline,ssim_value_baseline,cw_ssim_value_baseline,...
                UNIQUE_value_baseline,MS_UNIQUE_value_baseline,...
                csv_value_baseline, SUMMER_value_baseline};
            store_sidd_baseline = [store_sidd_baseline;new_row];

            % UPDATE MEDIAN TABLE
            new_row = {scene_instance, scene, phone_code, iso_level, shutter_speed, illum_temp,illum_bright,...
                psnr_value_median,ssim_value_median,cw_ssim_value_median,...
                UNIQUE_value_median,MS_UNIQUE_value_median,...
                csv_value_median, SUMMER_value_median};
            store_sidd_median = [store_sidd_median;new_row];

            % UPDATE WAVELET TABLE
            new_row = {scene_instance, scene, phone_code, iso_level, shutter_speed, illum_temp,illum_bright,...
                psnr_value_wavelet,ssim_value_wavelet,cw_ssim_value_wavelet,...
                UNIQUE_value_wavelet,MS_UNIQUE_value_wavelet,...
                csv_value_wavelet, SUMMER_value_wavelet};
            store_sidd_wavelet = [store_sidd_wavelet;new_row];
        end
    end
end

% WRITE TABLE TO EXCEL SPREADSHEET
writetable(store_sidd_baseline, "Analysis/ssid.xlsx", "Sheet", "Baseline", "Range", "A1");

% WRITE TABLE TO EXCEL SPREADSHEET
writetable(store_sidd_median, "Analysis/ssid.xlsx", "Sheet", "Median", "Range", "A1");

% WRITE TABLE TO EXCEL SPREADSHEET
writetable(store_sidd_wavelet, "Analysis/ssid.xlsx", "Sheet", "Wavelet", "Range", "A1");

% SAVE WORKSPACE
save("Analysis/ssid_workspace.mat");

%% Set12


% CREATE BASELINE TABLE
store_set12_baseline = cell2table({'00', 0,0,0,0,0,0, 0});
store_set12_baseline.Properties.VariableNames = ["File Path", "PSNR", "SSIM", "CW-SSIM", "UNIQUE", "MS-UNIQUE","CSV","SUMMER"];

% CREATE MEDIAN FILTER TABLE
store_set12_median = cell2table({'00', 0,0,0,0,0,0, 0});
store_set12_median.Properties.VariableNames = ["File Path", "PSNR", "SSIM", "CW-SSIM", "UNIQUE", "MS-UNIQUE","CSV","SUMMER"];

% CREATE BASELINE TABLE
store_set12_wavelet = cell2table({'00', 0,0,0,0,0,0, 0});
store_set12_wavelet.Properties.VariableNames = ["File Path", "PSNR", "SSIM", "CW-SSIM", "UNIQUE", "MS-UNIQUE","CSV","SUMMER"];

grouped_dir = ["/mnt/Set12/01.png", "/mnt/Set12/02.png", "/mnt/Set12/03.png", ...
    "/mnt/Set12/04.png", "/mnt/Set12/05.png", "/mnt/Set12/06.png", "/mnt/Set12/07.png", ...
    "/mnt/Set12/08.png", "/mnt/Set12/09.png", "/mnt/Set12/10.png", "/mnt/Set12/11.png", ...
    "/mnt/Set12/12.png"];

% iterate through groups
parfor ii = 1:length(grouped_dir)
    disp(ii)

    no_challenge_img = imread(grouped_dir(ii));
    
    % MEDIAN FILTER
    median_filt_img = median_filter(no_challenge_img,7,'symmetric');

    % WAVELET FILTER 
    wavelet_filt_img = wavelet_filter(no_challenge_img, 'haar');

    % CALCULATE MEDIAN FILTERED METRICS
    [psnr_value_median,ssim_value_median,cw_ssim_value_median,...
        UNIQUE_value_median,MS_UNIQUE_value_median,...
        csv_value_median,SUMMER_value_median] = metrics(median_filt_img,no_challenge_img);

    % CALCULATE MEDIAN FILTERED METRICS
    [psnr_value_wavelet,ssim_value_wavelet,cw_ssim_value_wavelet,...
        UNIQUE_value_wavelet,MS_UNIQUE_value_wavelet,...
        csv_value_wavelet,SUMMER_value_wavelet] = metrics(wavelet_filt_img,no_challenge_img);

    % UPDATE MEDIAN TABLE
    new_row = {grouped_dir(ii),...
        psnr_value_median,ssim_value_median,cw_ssim_value_median,...
        UNIQUE_value_median,MS_UNIQUE_value_median,...
        csv_value_median, SUMMER_value_median};
    store_set12_median = [store_set12_median;new_row];

    % UPDATE WAVELET TABLE
    new_row = {grouped_dir(ii),...
        psnr_value_wavelet,ssim_value_wavelet,cw_ssim_value_wavelet,...
        UNIQUE_value_wavelet,MS_UNIQUE_value_wavelet,...
        csv_value_wavelet, SUMMER_value_wavelet};
    store_set12_wavelet = [store_set12_wavelet;new_row];
end

% WRITE TABLE TO EXCEL SPREADSHEET
writetable(store_set12_median, "Analysis/Set12.xlsx", "Sheet", "Median", "Range", "A1");

% WRITE TABLE TO EXCEL SPREADSHEET
writetable(store_set12_wavelet, "Analysis/Set12.xlsx", "Sheet", "Wavelet", "Range", "A1");

% SAVE WORKSPACE
save("Analysis/set12_workspace.mat");

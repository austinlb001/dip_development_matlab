classdef datasets_reading
    methods(Static)

        %%%%%%%%%%%%%%%%%%%%%% CURE-OR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        function file_storage=cure_or_paths
            % BACKGROUND: 1:5 (INCLUDES 5)
            background = 1:1:5;

            % DEVICE TYPE: 1:5 (INCLUDES 5)
            device = 1:1:5;

            % OBJECT ORIENTATION: 1:5 (INCLUDES 5)
            objectOrientation = 1:1:5;

            % OBJECT TYPE: 000:100 (INCLUDES 100)
            object_type = 1:1:100;

            % CHALLENGETYPE: NO CHALLENGE 01, CHALLENGE 02:09 (INCLUDES 09), GRAYSCALE NO CHALLENGE 10, GRAYSCALE 11:18 (INCLUDES 18)
            challengeTypeColor = 1:1:9;
            challengeTypeGray = 10:1:18;
            
            % CHALLENGELEVEL: NO CHALLENGE 0, 1:5 (INCLUDES 5)

            % ASSIGN ROOT DIRECTORY
            if getenv('username') == "Katie"
                root_directory = "C:\Users\Katie\Documents\School\GaTech\Fall 2023 -Digital Image Processing\dippykit\Project_Images\CURE_OR\";
            elseif getenv("USER") == "austinlb001"
                root_directory = "/mnt/CURE-OR/";
            end
                root_directory = "C:\Users\Katie\Documents\School\GaTech\Fall 2023 -Digital Image Processing\dippykit\Project_Images\CURE_OR\";

            % GET ALL FILES
            if ispc
                file_list = dir(fullfile(root_directory, '**\*.jpg'));
            elseif isunix
                file_list = dir(fullfile(root_directory, '**/*.jpg'));
            end

            % CONSTRUCT FILE PATHS
            full_path = cell(size(file_list));
            parfor ii=1:size(file_list,1)
                full_path{ii} = fullfile(file_list(ii).folder, file_list(ii).name);
            end

            % SORT FILE PATHS
            iter1 = 0;
            file_store = cell(0);
            for idx1=background
                for idx2=device
                    for idx3=objectOrientation
                        iter2 = 0;
                        for idx4=object_type  
                            
                            % HANDLE COLOR IMAGES
                            file_beginning = strcat(num2str(idx1),"_",num2str(idx2),"_",num2str(idx3),"_",num2str(idx4,'%03.f'),"_",num2str(challengeTypeColor','%02.f'));                          
                            file_string = contains(full_path,cellstr(file_beginning));
                            if ~all(file_string==0)
                                iter2 = iter2 + 1;
                                file_store{iter2} = full_path(file_string);
                                full_path(file_string) = [];
                            end
                            
                            % HANDLE GRAYSCALE IMAGES
                            file_beginning = strcat(num2str(idx1),'_',num2str(idx2),'_',num2str(idx3),'_',num2str(idx4,'%03.f'),'_',num2str(challengeTypeGray','%02.f'));
                            file_string = contains(full_path,cellstr(file_beginning));          
                            if ~all(file_string==0)
                                iter2 = iter2 + 1;
                                file_store{iter2} = full_path(file_string);
                                full_path(file_string) = [];
                            end
                        end
                        iter1 = iter1 + 1;
                        file_storage{iter1} = file_store;
                    end
                end
            end
        end

        %%%%%%%%%%%%%%%%%%%%%%%%% CURE - TSR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        function file_storage = cure_tsr_paths

            % sequenceType: 1:2 (INCLUDES 2)
            sequenceType = 1:1:2;

            % signType: 01:14 (INCLUDES 14)
            signType = 1:1:14;

            % CHALLENGETYPE: 00 - No challenge; 01 - Decolorization; 02 - Lens blur; 03 - Codec error;
            % 04 - Darkening; 05 - Dirty lens; 06 - Exposure; 07 - Gaussian blur; 08 - Noise; 09 - Rain; 10 - Shadow; 11 - Snow; 12 - Haze
            % CHALLENGELEVEL: NO CHALLENGE 0, 1:5 (INCLUDES 5)

            % index: 1:1195
            index = 1:1:1195;

            % ASSIGN ROOT DIRECTORY
            if getenv('username') == "Katie"
                root_directory = "C:\Users\Katie\Documents\School\GaTech\Fall 2023 -Digital Image Processing\dippykit\Project_Images\CURE_TSR\Real_Test\Real_Test\";
            elseif getenv("USER") == "austinlb001"
                root_directory = "/mnt/CURE-TSR/test/";
            end

            % GET ALL FILES
            if ispc
                file_list = dir(fullfile(root_directory, '**\*.bmp'));
            elseif isunix
                file_list = dir(fullfile(root_directory, '**/*.bmp'));
            end

            % CONSTRUCT FILE PATHS
            full_path = cell(size(file_list));
            parfor ii=1:size(file_list,1)
                full_path{ii} = fullfile(file_list(ii).folder, file_list(ii).name);
            end

            % SORT FILES
            iter1 = 0;
            for idx1 = sequenceType
                for idx2 = signType
                    iter2 = 0;
                    for idx3 = index
                        file_beginning = num2str(idx1,'%02.f') + "_" + num2str(idx2,'%02.f') ;
                        pat = file_beginning + "_" + digitsPattern(2) + "_" + digitsPattern(2) +"_" + num2str(idx3,'%04.f');
                        file_string = contains(full_path,pat);

                        if ~all(file_string==0)
                            iter2 = iter2 +1;
                            file_store{iter2} = full_path(file_string);
                        end
                    end
                 iter1 = iter1 + 1;
                        file_storage{iter1} = file_store;
                end
            end
        end

        % CHALLENGETYPE: 00 - No challenge; 01 - Decolorization; 02 - Lens blur; 03 - Codec error;
        % 04 - Darkening; 05 - Dirty lens; 06 - Exposure; 07 - Gaussian blur; 08 - Noise; 09 - Rain; 10 - Shadow; 11 - Snow; 12 - Haze
        % CHALLENGELEVEL: NO CHALLENGE 0, 1:5 (INCLUDES 5)




        %%%%%%%%%%%%%%%%%%%%% CURE - TSD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


        function file_storage = cure_tsd_paths

            % sequenceType: 1:2 (INCLUDES 2)
            sequenceType = 1:1:2;

            % signType: 01:49 (INCLUDES 49)
            sequenceNumber = 1:1:49;

            % ASSIGN ROOT DIRECTORY
            if getenv('username') == "Katie"
                %root_directory = "C:\Users\Katie\Documents\School\GaTech\Fall 2023 -Digital Image Processing\dippykit\Project_Images\CURE_TSR\Real_Test\Real_Test\";
            elseif getenv("USER") == "austinlb001"
                root_directory = "/mnt/CURE-TSD/data/";
            end

            % GET ALL FILES
            if ispc
                file_list = dir(fullfile(root_directory, '**\*.mp4'));
            elseif isunix
                file_list = dir(fullfile(root_directory, '**/*.mp4'));
            end
            
            % CONSTRUCT FILE PATHS
            full_path = cell(size(file_list));
            parfor ii=1:size(file_list,1)
                full_path{ii} = fullfile(file_list(ii).folder, file_list(ii).name);
            end

            % PERFORM GROUPING
            iter1 = 0;
            file_store = cell(0);
            for idx1 = sequenceType
                iter2 = 0;
                for idx2 = sequenceNumber
                    file_beginning = strcat(num2str(idx1,'%02.f'),'_',num2str(idx2,'%02.f'));
                    file_string = contains(full_path,file_beginning);
                    if ~all(file_string==0)
                        iter2 = iter2 + 1;
                        file_store{iter2} = full_path(file_string);
                    end
                end
            iter1 = iter1 + 1;
            file_storage{iter1} = file_store;
            end
        end

        %%%%%%%%%%%%%%%%%%%%% SIDD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        function file_storage=sidd_paths
            % BACKGROUND: 1:200 (INCLUDES 200)
            scene_instance_number = 1:1:200;

            % DEVICE TYPE: 1:5 (INCLUDES 10)
            scene_number = 1:1:10;

            % ASSIGN ROOT DIRECTORY
            if getenv('username') == "Katie"
                root_directory = "C:\Users\Katie\Documents\School\GaTech\Fall 2023 -Digital Image Processing\dippykit\Project_Images\CURE_OR\";
            elseif getenv("USER") == "austinlb001"
                root_directory = "/mnt/SIDD/SIDD_Small_sRGB_Only/Data/";
            end

            % GET ALL FILES
            if ispc
                file_list = dir(fullfile(root_directory, '**\*.PNG'));
            elseif isunix
                file_list = dir(fullfile(root_directory, '**/*.PNG'));
            end

            % CONSTRUCT FILE PATHS
            full_path = cell(size(file_list));
            parfor ii=1:size(file_list,1)
                    full_path{ii} = fullfile(file_list(ii).folder, file_list(ii).name);
            end

            % SORT FILE PATHS
            iter1 = 0;
            file_store = cell(0);
            for idx1=scene_instance_number
                iter2 = 0;
                for idx2=scene_number      
                    file_beginning = strcat(num2str(idx1, '%04.f'),"_",num2str(idx2, '%03.f'));                          
                    file_string = contains(full_path,file_beginning);
                    if ~all(file_string==0)
                        iter2 = iter2 + 1;
                        file_store{iter2} = full_path(file_string);
                        full_path(file_string) = [];
                    end
                end
                iter1 = iter1 + 1;
                file_storage{iter1} = file_store;
            end

        end

    end
end

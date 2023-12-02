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

            %CHALLENGETYPE: NO CHALLENGE 01, CHALLENGE 02:09 (INCLUDES 09), GRAYSCALE NO CHALLENGE 10, GRAYSCALE 11:18 (INCLUDES 18)
            % CHALLENGELEVEL: NO CHALLENGE 0, 1:5 (INCLUDES 5)
            
            % ASSIGN ROOT DIRECTORY
            if getenv('username') == "Katie"
                root_directory = "C:\Users\Katie\Documents\School\GaTech\Fall 2023 -Digital Image Processing\dippykit\Project_Images\CURE_OR\";
            elseif getenv("USER") == "austinlb001"
                root_directory = "/run/media/austinlb001/DATA2/CURE-OR/";
            end
           
            % GET ALL FILES
            if ispc
                file_list = dir(fullfile(root_directory, '**\*.jpg'));
            elseif isunix
                file_list = dir(fullfile(root_directory, '**/*.jpg'));
            end

            % CONSTRUCT FILE PATHS
            full_path = cell(size(file_list));
            for ii=1:size(file_list,1)
                full_path{ii} = fullfile(file_list(ii).folder, file_list(ii).name); 
            end 
            
            % SORT FILE PATHS
            iter1 = 0;
            for idx1=background 
                for idx2=device 
                    for idx3=objectOrientation
                            iter2 = 0;
                        for idx4=object_type 
                            file_beginning = strcat(num2str(idx1),'_',num2str(idx2),'_',num2str(idx3),'_',num2str(idx4,'%03.f'));
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
            end
        end 

%%%%%%%%%%%%%%%%%%%%%%%%% CURE - TSR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function file_storage = cure_tsr_paths
   
    % sequenceType: 1:2 (INCLUDES 2)
    sequenceType = 1:1:2;

    % signType: 01:14 (INCLUDES 14)
    signType = 1:1:14;

    % index: 1:1195
    index = 1:1:1195;
            
    % ASSIGN ROOT DIRECTORY
    if getenv('username') == "Katie"
        root_directory = "C:\Users\Katie\Documents\School\GaTech\Fall 2023 -Digital Image Processing\dippykit\Project_Images\CURE_TSR\Real_Test\Real_Test\";
    elseif getenv("USER") == "austinlb001"
        root_directory = "/run/media/austinlb001/DATA2/CURE-TSR/test/Real_Test/";
    end
    
    % GET ALL FILES
    if ispc
        file_list = dir(fullfile(root_directory, '**\*.jpg'));
    elseif isunix
        file_list = dir(fullfile(root_directory, '**/*.jpg'));
    end
    
    % CONSTRUCT FILE PATHS
    full_path = cell(size(file_list));
    for ii=1:size(file_list,1)
        full_path{ii} = fullfile(file_list(ii).folder, file_list(ii).name); 
    end 
    
    % SORT FILES
    iter1 = 0;
    for idx1 = sequenceType
        for idx2 = signType
            iter2 = 0;
            for idx3 = index
                [~,name,~] = fileparts(full_path);
                    file_beginning = strcat(num2str(idx1,'%02.f'),'_',num2str(idx2,'%02.f'));
                    file_string = contains(full_path,file_beginning) & name(end-3:end)==num2str(index,'%04.f');
                    if ~all(file_string==0)
                        iter2 = iter2 + 1;
                    file_store{iter2} = full_path(file_string);
                    end
            end
                    iter1 = iter1 + 1;
                    file_storage{iter1} = file_store;
                    end 
                end 
            end 
end 

   % CHALLENGETYPE: 00 - No challenge; 01 - Decolorization; 02 - Lens blur; 03 - Codec error; 
        % 04 - Darkening; 05 - Dirty lens; 06 - Exposure; 07 - Gaussian blur; 08 - Noise; 09 - Rain; 10 - Shadow; 11 - Snow; 12 - Haze
    % CHALLENGELEVEL: NO CHALLENGE 0, 1:5 (INCLUDES 5)
end
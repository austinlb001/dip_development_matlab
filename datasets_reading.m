classdef datasets_reading
    methods(Static)
        function file_storage=cure_or_paths
            % BACKGROUND: 1:6 (EXCLUDES 6)
            background = [1:6];
    
            % DEVICE TYPE: 1:6 (EXCLUDES 6)
            device = [1:6];
    
            % OBJECT ORIENTATION: 1:6 (EXCLUDES 6)
            objectOrientation = [1:6];
    
            % OBJECT TYPE: 000:101 (EXCLUDES 100)
            object_type = [1:101];

            %CHALLENGETYPE: NO CHALLENGE 01, CHALLENGE 02:09 (INCLUDES 09), GRAYSCALE NO CHALLENGE 10, GRAYSCALE 11:18 (INCLUDES 18)
            % CHALLENGELEVEL: NO CHALLENGE 0, 1:5 (INCLUDES 5)
            file_paths_temp = [];
            file_paths = [];
            files_store = [];
            
            % File lists
            root_directory = "C:\Users\Katie\Documents\School\GaTech\Fall 2023 -Digital Image Processing\dippykit\Project_Images\CURE_OR\";
            file_list = dir(fullfile(root_directory, '**\*.jpg'));

            % Full file paths

            for ii=1:size(file_list,1)
            
                file_name = file_list(ii).name;
                
                file_dir = file_list(ii).folder;

                full_path{ii} = fullfile(file_dir,file_name); 

            end 
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
                disp(idx4)
            end


        end 
    end

end
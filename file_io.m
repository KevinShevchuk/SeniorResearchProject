function [count] = file_io( file_name )
% Handles file I/O for the application.

    % Input Parameters:
        % file_name - Name of the file to be read from.

    % Return Parameters:
        % count - counter for the number of lines in the file.

global test_debug_flag
global header_data % The cell array holding the header specifications.
global aper_def % The cell array holding all the aperture definition data.
global line_data % The cell array holding the sequential commands.

    aper_def = cell(999,5); % Initialize empty aperture definition array.
    line_data = cell(1,6);
    header_data = cell(1,7);
    
    in_file = fopen(file_name);
    if (in_file == -1)
        error('file can''t be read');
    end
    
    tline = fgetl(in_file);
    count = 1; % Line counter for read in lines.
    while ischar(tline)
          
        if (strncmpi(tline, '%', 1) == 1) % Find the Header.
            if (strncmpi(tline, '%ADD', 4) == 1) % Its an Apeture Definition.
                ad_parse(tline) % Call the aperture parser.
            elseif (strncmpi(tline, '%L', 2) == 0) % Its not an Apeture Definition.
                hd_parse(tline)        
            end
        elseif (strncmpi(tline, 'G04', 3) == 0) && (strncmpi(tline, 'M', 1) == 0)% Its a comment, ignore it.
            line_parse(tline, count) % Call the line parser.
            count = count + 1;
        else
        end
        tline = fgets(in_file);
    end   
    fclose(in_file);
    
    if (test_debug_flag == 1) % Display aperture definition table.
        disp('File I/O Completed Successfully')
    end
end


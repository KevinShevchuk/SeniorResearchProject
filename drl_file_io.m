function [count] = drl_file_io( file_name )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

global test_debug_flag
global drill_present
global drl_data % The cell array holding the header specifications.
global drl_def % The cell array holding all the aperture definition data.
global drl_header_data % The cell array holding the sequential commands.

    drl_def = cell(99,3); % Initialize empty aperture definition array.
    drl_data = cell(1,7);
    drl_header_data = cell(1,7);
    
    in_file = fopen(file_name);
    if (in_file == -1)
        error('File can''t be read');
    end
    
    tline = fgetl(in_file);
    header_flag = 0; %indicates currently reading the header.
    count = 0; % Line counter for read in lines.
    while ischar(tline)
        if (strncmpi(tline, 'M48', 3) == 1) % Find the Header.
            header_flag = 1;
        end
        if (strncmpi(tline, '%', 1) == 1) || (strncmpi(tline, 'M95', 3) == 1)
            header_flag = 0;
        end
        if (header_flag == 1);
            dh_parse(tline) % Call the aperture parser.
        else
            count = count + 1;
            drl_parse(tline, count)
        end
        tline = fgets(in_file);
    end   
    fclose(in_file);
    drill_present = 1;
    
    if (test_debug_flag == 1) % Display aperture definition table.
        disp('Drill File I/O Completed Successfully')
    end
end


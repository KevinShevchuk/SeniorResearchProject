function line_parse( line, count )
%Parses each line of the gerber file that isn't part of the aperture
%definitions or the intro.

    % Input Parameters:
        % line - a buffer containing the data for the current line waiting
        %   to be parsed.
        % count - current line count. this is used to put the parsed data
        %   into the correct row in the line_data matrix.

    % The drawing data is stored in an Nx7 matrix. Below are the column
    % definitions.
        %   [1] Holds function numbers, denoted by G
        %   [2] Holds X coordinates.
        %   [3] Holds Y coordinates.
        %   [4] Holds Aperture selections denoted by D.
        %   [5] Holds X direction offset, denoted by I.
        %   [6] Holds Y direction offset, denoted by J.

global line_data
global header_data
global test_debug_flag
    
    while isempty(line) == 0
        if (strncmpi(line, 'G', 1) == 1)
            [temp, line] = strtok(line, {'G', 'D', 'X', 'Y', 'I', 'J', '*'});
            line_data{count, 1} = str2double(temp);
        elseif (strncmpi(line, 'X', 1) == 1)
            [temp, line] = strtok(line, {'G', 'D', 'X', 'Y', 'I', 'J', '*'});
            line_data{count, 2} = str2double(temp);
        elseif (strncmpi(line, 'Y', 1) == 1)
            [temp, line] = strtok(line, {'G', 'D', 'X', 'Y', 'I', 'J', '*'});
            line_data{count, 3} = str2double(temp);  
        elseif (strncmpi(line, 'D', 1) == 1)
            [temp, line] = strtok(line, {'G', 'D', 'X', 'Y', 'I', 'J', '*'});
            line_data{count, 4} = str2double(temp);
        elseif (strncmpi(line, 'I', 1) == 1)
            [temp, line] = strtok(line, {'G', 'D', 'X', 'Y', 'I', 'J', '*'});
            line_data{count, 5} = str2double(temp);  
        elseif (strncmpi(line, 'J', 1) == 1)
            [temp, line] = strtok(line, {'G', 'D', 'X', 'Y', 'I', 'J', '*'});
            line_data{count, 6} = str2double(temp);
        else
            break;
        end
    end
    % Replace proper decimal places.
    line_data{count, 2} = line_data{count, 2} /10^(header_data{1, 4});
    line_data{count, 3} = line_data{count, 3} /10^(header_data{1, 4});   
end


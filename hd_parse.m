function hd_parse( line )
% This function parses the data from the header portion of the gerber file
% extracting the information required to properly render the image. 

    % Input Parameters
        % line - a buffer containing the current line data.

    % The header data is stored in a 1x7 matrix in which the fields are
    % described below.
        %   [1] Leading or trailing zeroes flag. 0 if not set, 1 if leading is set,
        %       2 if trailing is set.
        %   [2] Coordinate specification. 0 for no specification, 1 for absolute, 2
        %       for incremental.
        %   [3] specification of integers in the format.
        %   [4] specification of number of decimal places in the format.
        %   [5] specification of inches or millimeters.
        %   [6] X direction scale factor
        %   [7] Y direction scale factor

global header_data

    line = line(2:end);
    
    if (strncmpi(line, 'F', 1) == 1);
        line = line(3:end);
        if (strncmpi(line, 'L', 1) == 1);
            header_data{1, 1} = 1; %Grab Leading zeroes flag.
            line = line(2:end);
        else (strncmpi(line, 'T', 1) == 1);
            header_data{1, 1} = 2; % Grab Trailing zeroes flag.
            line = line(2:end);
        end
        if (strncmpi(line, 'A', 1) == 1);
            header_data{1, 2} = 1; %Grab Absolute coordinates flag.
            line = line(2:end);
        else (strncmpi(line, 'I', 1) == 1);
            header_data{1, 2} = 2; %Grab Incremental coordinates flag.
            line = line(2:end);
        end
        if (strncmpi(line, 'X', 1) == 1);
            line = line(2:end);
            header_data{1, 3} = str2double(line(1)); % Grab first zeros specification.
            line = line(2:end);
            header_data{1, 4} = str2double(line(1)); % Grab second zeroes specification.
            line = line(5:end);
            [temp, line] = strtok(line, {'X', 'Y', '*'});
            header_data{1, 5} = temp; % Grab the measurment specification.
        else
            error('Unrecognized Header Syntax')
        end
    else
       k = strfind(line, 'SF');
       line = line(k+2:end);
       if (strncmpi(line, 'A', 1) == 1)
            [temp, line] = strtok(line, {'A', 'B', '*'});
            temp = str2double(temp);
            header_data{1, 6} = temp; % Grab X scale factor.
            [temp, line] = strtok(line, {'A', 'B', '*'});
            temp = str2double(temp);
            header_data{1, 7} = temp; % Grab Y scale factor.
       else
           error('Unrecognized Header Syntax')
       end
    end
end
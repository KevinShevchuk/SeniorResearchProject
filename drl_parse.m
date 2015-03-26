function drl_parse( line, count )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    % Input Parameters:
        % line - a buffer containing the data for the current line waiting
        %   to be parsed.
        % count - current line count. this is used to put the parsed data
        %   into the correct row in the line_data matrix.

    % The drawing data is stored in an Nx7 matrix. Below are the column
    % definitions.
        %   [1] Holds function numbers, denoted by G or R
        %   [2] Holds X coordinates.
        %   [3] Holds Y coordinates.
        %   [4] Holds Tool selections denoted by T.
        %   [5] Holds repeat count.
        %   [6] Holds X repeat factor.
        %   [6] Holds Y repeat factor.

global drl_data
global drl_header_data
global current_def

    while isempty(line) == 0
        if (strncmpi(line, 'T', 1) == 1)
            line = line(2:end);
            current_def = str2double(line);
            drl_data{count, 1} = str2double(line);
        elseif (strncmpi(line, 'X', 1) == 1)
            [temp, line] = strtok(line, {'G', 'D', 'X', 'Y', 'I', 'J', '*'});
            drl_data{count, 2} = str2double(temp);
            drl_data{count, 4} = current_def;
        elseif (strncmpi(line, 'Y', 1) == 1)
            [temp, line] = strtok(line, {'G', 'D', 'X', 'Y', 'I', 'J', '*'});
            drl_data{count, 3} = str2double(temp);
            drl_data{count, 4} = current_def;
        elseif (strncmpi(line, 'R', 1) == 1)
            line = line(2:end);
            [temp, line] = strtok(line, {'G', 'D', 'X', 'Y', 'I', 'J', '*'});
            drl_data{count, 5} = str2double(temp);
            if (strncmpi(line, 'X', 1) == 1)
                [temp, line] = strtok(line, {'G', 'D', 'X', 'Y', 'I', 'J', '*'});
                drl_data{count, 6} = str2double(temp);
            else
                drl_data{count, 6} = 0;
            end
            if (strncmpi(line, 'Y', 1) == 1)
                [temp, line] = strtok(line, {'G', 'D', 'X', 'Y', 'I', 'J', '*'});
                drl_data{count, 7} = str2double(temp);
            else
                drl_data{count, 7} = 0;
            end
        elseif (strncmpi(line, 'G', 1) == 1)
            drl_data{count, 1} = line;
            line = line(4:end);
        elseif (strncmpi(line, 'M', 1) == 1)
            drl_data{count, 1} = line;
            line = line(4:end);
        elseif (strncmpi(line, '%', 1) == 1)
            drl_data{count, 1} = line;
            line = line(2:end);
        else
            break;
        end
    end
    if (~isempty(drl_data{count, 2})) && (~isempty(drl_data{count, 3}))
        drl_data{count, 2} = drl_data{count, 2} /10^(drl_header_data{1, 4});
        drl_data{count, 3} = drl_data{count, 3} /10^(drl_header_data{1, 4});
    end
    if (~isempty(drl_data{count, 6})) && (~isempty(drl_data{count, 7}))
        drl_data{count, 6} = drl_data{count, 6} /10^(drl_header_data{1, 4});
        drl_data{count, 7} = drl_data{count, 7} /10^(drl_header_data{1, 4});
    end
    % Replace proper decimal places.
end


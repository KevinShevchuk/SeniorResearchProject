function  dh_parse( line )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    % Input Parameters
        % line - a buffer containing the current line data.

    % The header data is stored in a 1xN matrix in which the fields are
    % described below.
        %   [1] Metric or Inches. 1 if Inches, 0 if Metric.
        %   [2] Leading or trailing zeroes flag. 0 if not set, 1 if leading is set,
        %       2 if trailing is set.

global drl_header_data
global drl_def
    
    if (strncmpi(line, 'INCH', 4) == 1); %Inches or Metric.
        drl_header_data{1, 1} = 1;
        [temp, line] = strtok(line, {','});
        line = line(2:end);
        if (strncmpi(line, 'TZ', 2) == 1); %Trailing Zeroes.
            line = line(3:end);
            if (length(line) == 2) %line contains nothing but null terminator
                drl_header_data{1, 4} = 3; %default
            else
                drl_header_data{1, 4} = str2double(line);
            end
        elseif (strncmpi(line, 'LZ', 2) == 1); %Leading Zeroes.
            line = line(3:end);
            if (length(line) == 2) %line contains nothing but null terminator
                drl_header_data{1, 4} = 3; %default
            else
                drl_header_data{1, 4} = str2double(line);
            end
        end
    end
    if (strncmpi(line, 'METR', 4) == 1); %Inches or Metric.
        drl_header_data{1, 1} = 0;
        [temp, line] = strtok(line, {','});
        line = line(2:end);
        if (strncmpi(line, 'TZ', 2) == 1); %Trailing Zeroes.
            line = line(3:end);
            if (~isempty(line))
                drl_header_data{1, 4} = str2double(line);
            else
                drl_header_data{1, 4} = 4 %default
            end
        elseif (strncmpi(line, 'LZ', 2) == 1); %Leading Zeroes.
            line = line(3:end);
            if (~isempty(line))
                drl_header_data{1, 4} = str2double(line);
            else
                drl_header_data{1, 4} = 4 %default
            end
        end
    end
    if (strncmpi(line, 'T', 1) == 1);
        line = line(2:end);
        [temp, line] = strtok(line, {'C'});
        line = line(2:end);
        line = str2double(line);
        temp = str2double(temp);
        drl_def{temp, 1} = line; % Grab Y scale factor.
    end
end


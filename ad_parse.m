function ad_parse( line )
% Parses the Aperture Defintion section of the header to establish the
% shapes needed for drawing.

    % Input Parameters:
        % line - the current line number on the gerber file.

    % aper_def is stored in an Nx5 matrix. Below are the column descriptions.
        %   [1] Holds shape type, denoted by either an R for rectangle, C for
        %       circle, O for oblong, or P for polygon.
        %   [2] Holds X radius.
        %   [3] Holds Y radius.
        %   [4] Holds inset X dimension. If only this is present, the inset is a
        %       circle.
        %   [5] Holds inset Y direction offset. If present, inset is a rectangle
        %       and this is the Y dimension.

global test_debug_flag
global aper_def % The cell array holding all the aperture definition data.
    
    row = 0;
    line = line(4:end);
    
    % Get the definition number.
    if (strncmpi(line, 'D', 1) == 1)
        [temp, line] = strtok(line, {'D', 'R', 'O', 'C', 'P', 'X', ',', '*'});
        row = str2num(temp);
    else
        disp(aper_def)
        error('Unrecognized Aperture Definition Syntax')
    end    
    
    % Get the aperture shape.
    if (strncmpi(line, 'R', 1) == 1)
        aper_def{row, 1} = 'R';
    elseif (strncmpi(line, 'C', 1) == 1)
        aper_def{row, 1} = 'C';
    elseif (strncmpi(line, 'P', 1) == 1)
        aper_def{row, 1} = 'P';
    elseif (strncmpi(line, 'O', 1) == 1)
        aper_def{row, 1} = 'O';
    else
        disp(aper_def)
        error('Unrecognized Aperture Definition Syntax')
    end
    
    % Check for second dimension.
    [temp, line] = strtok(line, {'D', 'R', 'O', 'C', 'P', 'X', ',', '*'});
    temp = str2num(temp);
    aper_def{row, 2} = temp;
    if (strncmpi(line, 'X', 1) == 1)
        [temp, line] = strtok(line, {'D', 'R', 'O', 'C', 'P', 'X', ',', '*'});
        temp = str2num(temp);
        aper_def{row, 3} = temp;
    end
    
    % Check for hole specifications. If only one dimension exists the hole
    % is a circle.
    if (strncmpi(line, 'X', 1) == 1)
        [temp, line] = strtok(line, {'D', 'R', 'O', 'C', 'P', 'X', ',', '*'});
        temp = str2num(temp);
        aper_def{row, 4} = temp;
        % Get second hole dimension. If this exists, the hole is a square.
        if (strncmpi(line, 'X', 1) == 1)
            [temp, line] = strtok(line, {'D', 'R', 'O', 'C', 'P', 'X', ',', '*'});
            temp = str2num(temp);
            aper_def{row, 5} = temp;
        end
    end
end


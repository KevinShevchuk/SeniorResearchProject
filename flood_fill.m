function flood_fill( x, y )
% Performs flood filling of a shape on the image beginning from point (x,
% y).

    % Input Parameters:
        % x = x coordinate inside a shape, is the center point for a
        %   circle.
        % y = y coordinate inside a shape, is the center point for a
        %   circle.
    global gerber
        
    LastFlood = zeros(size(gerber));
    Flood = LastFlood;
    Flood(x, y) = 1;
    Mask = (gerber == gerber(y, x));
    FloodFilter = [0,1.0,0; 1.0,1.0,1.0; 0,1.0,0];
    while any(LastFlood(:) ~= Flood(:))
        LastFlood = Flood;
        Flood = convn(Flood, FloodFilter, 'same') & Mask;
    end
    
    gerber(find(Flood)) = 1;
end

% This function was written by Pascal Getreuer, January 2006 as part of his
% Writing Fast MATLAB Code series. It has been modified for this project.

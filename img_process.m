function [filtered] = img_process( filename )
% Performs image processing on the scanned in source image. This process
% entirely relies on RGB pixel value ratios. These ratios can find at least
% 98% of the copper on the board.

global source
global source_binary

    source = imread(filename);
    [x, y, z] = size(source);
    source_binary = zeros(x, y);
    
    % Extract the copper based on RGB pixel rules.
        % Rule 1: R is greater than G+21.
        % Rule 2: G is greater than B+30 when R is greater than G+15.
    
    for i = 1:x
        for j = 1:y
            if (source(i,j,1) > source(i,j,2)+21)
                source_binary(i, j) = 1;
            elseif (source(i,j,1) > source(i,j,2)+15)
                if (source(i,j,2) < source(i,j,3)+15) %30
                    source_binary(i, j) = 1;
                end
            end
            if (source(i,j,1) > 245); % Get reflections too.
                source_binary(i, j) = 1;
            end
        end
    end
    
    % Filter the binary image to remove false positives.
    filtered = medfilt2(source_binary, [3, 3]);
    
    % Morph image to clean up the edges.
%     se = strel('diamond', 2);
%     closed = imclose(filtered, se);
%     imshow(closed)
end


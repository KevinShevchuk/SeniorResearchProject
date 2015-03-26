function [ dim_x, dim_y ] = gerb_preproc(line_count)
% Preprocesses the file data in preparation for rasterizing the image. This
% includes finding the bounds of the figure, grounding it back to the
% origin if it is too far away, and mirroring the image across the x axis
% to unify coordinate systems.

    % Input Parameters:
        % line_count - number of lines in the gerber file.
        
    % Return Parameters:
        % dim_x - width of the file in the designated coordinate system
        %   specified by the header.
        % dim_y - height of the file in the designated coordinate system
        %   specified by the header.

global test_debug_flag
global line_data
global header_data
global offset_x
global offset_y
    
    % Make incremental coordinates into absolute coordinates.
    if (header_data{1, 2} == 2)
        x = 0;
        y = 0;
        count = 0;
        while (count < line_count)
            if (~isempty(line_data{count, 2}))
                x = x + line_data{count, 2};
                line_data{count, 2} = x;
            end
            if (~isempty(line_data{count, 3}))
                y = y + line_data{count, 2};
                line_data{count, 2} = y;
            end
        end
    end

    % Find the complete X and Y bounds for the image.
    count = 1;
    min_x = 0;
    max_x = 0;
    min_y = 0;
    max_y = 0;
    curr_ad = 0; %current aperture definition.
    curr_x = 0;
    curr_y = 0;

    % Find first X value.
    while (isempty(line_data{count, 2}))
        count = count + 1;
    end
    min_x = line_data{count, 2};
    max_x = line_data{count, 2};
    count = 1;

    % Find first Y value
    while (isempty(line_data{count, 3}))
        count = count + 1;
    end
    min_y = line_data{count, 3};
    max_y = line_data{count, 3};
    count = 1;

    curr_x = min_x;
    curr_y = min_y;

    while (count < line_count)
        if (line_data{count, 4} > 9)
            curr_ad = line_data{count, 4};
        end
        if (~isempty(line_data{count, 2}))
            curr_x = line_data{count, 2};
        end
        if (~isempty(line_data{count, 3}))
            curr_y = line_data{count, 3};
        end
        if (curr_ad ~= 0)
            [min_x, max_x, min_y, max_y] = poly_bounds(count, curr_ad, curr_x, curr_y, min_x, max_x, min_y, max_y);
        end    
        count = count + 1;
    end

    dim_x = max_x - min_x;
    dim_y = max_y - min_y;
    height = dim_y;
    width = dim_x;

    offset_x = max_x - dim_x;
    offset_y = max_y - dim_y;

    %Ground the image back to the origin.    
    count = 1;
    while (count < line_count)
        if (~isempty(line_data{count, 2}))
            line_data{count, 2} = line_data{count, 2} - offset_x;
        end
        if (~isempty(line_data{count, 3}))
            line_data{count, 3} = line_data{count, 3} - offset_y;
        end
        count = count + 1;
    end

    %Mirror along the X axis. (This is to unify coordinate systems.)
    count = 1;
    while (count < line_count)
        if (~isempty(line_data{count, 3}))
            line_data{count, 3} = dim_y - line_data{count, 3};
        end
        count = count + 1;
    end
    
    if (test_debug_flag == 1) % Display aperture definition table.
        disp('Preprocessing Completed Successfully')
    end
end


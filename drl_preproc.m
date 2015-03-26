function drl_preproc( line_count, dim_x, dim_y )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

global drill_present
global drl_data % The cell array holding the header specifications.
global drl_def % The cell array holding all the aperture definition data.
global drl_header_data % The cell array holding the sequential commands.
global offset_x
global offset_y


    %Ground the image back to the origin.    
    count = 1;
    while (count < line_count)
        if (~isempty(drl_data{count, 2}))
            drl_data{count, 2} = drl_data{count, 2} - offset_x;
        end
        if (~isempty(drl_data{count, 3}))
            drl_data{count, 3} = drl_data{count, 3} - offset_y;
        end
        count = count + 1;
    end

    %Mirror along the Y axis. (This is to unify coordinate systems.)
    count = 1;
    while (count < line_count)
        if (~isempty(drl_data{count, 3}))
            drl_data{count, 3} = dim_y - drl_data{count, 3};
        end
        if (~isempty(drl_data{count, 7}))
            drl_data{count, 7} = drl_data{count, 7}*-1;
        end
        count = count + 1;
    end
end


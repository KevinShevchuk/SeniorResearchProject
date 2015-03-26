function [ shape_min_x, shape_max_x, shape_min_y, shape_max_y ] = poly_bounds( index, curr_ad, curr_x, curr_y, min_x, max_x, min_y, max_y)
% Computes the bounds of the aperture definition at the current point.
%   Detailed explanation goes here
global aper_def
    
    if (aper_def{curr_ad, 1} == 'C')
        shape_min_x = curr_x - aper_def{curr_ad, 2};
        shape_max_x = curr_x + aper_def{curr_ad, 2};
        shape_min_y = curr_y - aper_def{curr_ad, 2};
        shape_max_y = curr_y + aper_def{curr_ad, 2};
    elseif (aper_def{curr_ad, 1} == 'R' || aper_def{ curr_ad, 1} == 'O')    
        shape_min_x = curr_x - aper_def{curr_ad, 2};
        shape_max_x = curr_x + aper_def{curr_ad, 2};
        shape_min_y = curr_y - aper_def{curr_ad, 3};
        shape_max_y = curr_y + aper_def{curr_ad, 3};
    else
    end
    
    % find the more extreme values.
    if(min_x < shape_min_x)
        shape_min_x = min_x;
    end
        
    if(max_x > shape_max_x)
        shape_max_x = max_x;
    end
    
    if(min_y < shape_min_y)
        shape_min_y = min_y;
    end
    
    if(max_y > shape_max_y)
        shape_max_y = max_y;
    end
end
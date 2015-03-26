function draw_board(line_count, x, y)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global line_data
global aper_def
global render_sf
global gerber
global board_rendered
    
    render_sf = 1200; % pixels per inch
    count = 1;
    curr_ad = 0;
    prev_x = 0;
    curr_x = 0;
    prev_y = 0;
    curr_y = 0;
    
    gerber = zeros(y*render_sf,x*render_sf);
    
%     imshow(blank_img);
%     colormap(gray);
%     axis off;
%     axis image;
    
    while count < line_count
        if (~isempty(line_data{count, 4}))
            if (line_data{count, 4} > 9)
                curr_ad = line_data{count, 4};
            end
        end
        if (~isempty(line_data{count, 2}))
            prev_x = curr_x;
            curr_x = line_data{count, 2};
        else
            prev_x = curr_x;
        end
        if (~isempty(line_data{count, 3}))
            prev_y = curr_y;
            curr_y = line_data{count, 3};
        else
            prev_y = curr_y;
        end
        if (curr_ad ~= 0) % Outline fills are not supported yet.
            if (line_data{count, 4} == 1)
                draw_line(prev_x, curr_x, prev_y, curr_y, curr_ad);
            elseif (line_data{count, 4} == 3)
                if (aper_def{curr_ad, 1} == 'R')
                    draw_rect(curr_x, curr_y, curr_ad);
                elseif (aper_def{curr_ad, 1} == 'C')
                    draw_circle(curr_x, curr_y, curr_ad, 1);
                elseif (aper_def{curr_ad, 1} == 'O')
                    % draw_oblong
                elseif (aper_def{curr_ad, 1} == 'P')
                    % draw_polygon
                else
                    error('Unsupported Shape Detected');
                end
            %elseif
            %   draw_arc();
            else
            end
        else
        end
        count = count + 1;
    end
    board_rendered = 1;
end


function draw_drl(line_count, x, y)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

global drl_data
global drl_holes
global render_sf
global board_rendered
global drl_rendered
    
    render_sf = 1200; % pixels per inch
    count = 1;
    curr_ad = 0;
    prev_x = 0;
    curr_x = 0;
    prev_y = 0;
    curr_y = 0;
    
    if (board_rendered == 1)
        while count < line_count
            if (~isempty(drl_data{count, 4}))
                curr_ad = drl_data{count, 4};
            end
            if (~isempty(drl_data{count, 2}))
                prev_x = curr_x;
                curr_x = drl_data{count, 2};
            else
                prev_x = curr_x;
            end
            if (~isempty(drl_data{count, 3}))
                prev_y = curr_y;
                curr_y = drl_data{count, 3};
            else
                prev_y = curr_y;
            end
            if (curr_ad ~= 0) % Outline fills are not supported yet.
                if (~isempty(drl_data{count, 4}))
                    draw_circle(curr_x, curr_y, curr_ad, 0);
                    drl_holes{count, 1} = str2double(curr_x);
                    drl_holes{count, 2} = str2double(curr_y);
                elseif (~isempty(drl_data{count, 5}))
                    for i = 1:drl_data{count, 5}
                        curr_x = curr_x + drl_data{count, 6};
                        curr_y = curr_y + drl_data{count, 7};
                        drl_holes{count, 1} = str2double(curr_x);
                        drl_holes{count, 2} = str2double(curr_y);
                        draw_circle(curr_x, curr_y, curr_ad, 0);
                    end
                else
                    %error('Unsupported Shape Detected');
                end
            end
            count = count + 1;
        end
    end
    drl_rendered = 1;
end


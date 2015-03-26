function draw_circle( curr_x, curr_y, curr_ad, polarity )
% Draws a circle using the Circle Midpoint Algorithm, then uses a custom
% algorithm to fill it in.
global render_sf
global aper_def
global drl_def
global gerber
    
    %Midpoint Circle Algorithm
    if (polarity == 1)
        x = round((aper_def{curr_ad, 2}/2)*render_sf);
    elseif (polarity == 0)
        t = drl_def{curr_ad, 1};
        x = round((drl_def{curr_ad, 1}/2)*render_sf);
    else
        error('Invalid Polarity Value, must be 0 or 1.');
    end
    round_x = round(curr_x*render_sf);
    round_y = round(curr_y*render_sf);
    y = 0;
    radiusError = 1-x;
    while (x >= y)
        gerber(y + round_y, x + round_x) = polarity;
        gerber(x + round_y, y + round_x) = polarity;
        gerber(y + round_y, -x + round_x) = polarity;
        gerber(x + round_y, -y + round_x) = polarity;
        gerber(-y + round_y, -x + round_x) = polarity;
        gerber(-x + round_y, -y + round_x) = polarity;
        gerber(-y + round_y, x + round_x) = polarity;
        gerber(-x + round_y, y + round_x) = polarity;
        y = y + 1;
        if (radiusError < 0)
            radiusError = radiusError + 2*(y+1);
        else
            x = x - 1;
            radiusError = radiusError + 2*(y-x+1);
        end
    end
    
    % The above code is not my original work, it is modified to work with
    % this program.
    
    x = 0;
    y = 1;
    % While the x axis has not encountered the edge of the circle....
    while (gerber(round_y, round_x + x) ~= polarity) && (gerber(round_y, round_x - x) ~= polarity)
        %...Change pixels  on the y axis until it hits the edge.
        while (gerber(round_y + y, round_x + x) ~= polarity) && (gerber(round_y - y, round_x + x) ~= polarity)
            gerber(round_y + y, round_x + x) = polarity;
            gerber(round_y - y, round_x + x) = polarity;
            y = y + 1;
        end
        y = 1;
        while (gerber(round_y + y, round_x - x) ~= polarity) && (gerber(round_y - y, round_x - x) ~= polarity)
            gerber(round_y + y, round_x - x) = polarity;
            gerber(round_y - y, round_x - x) = polarity;
            y = y + 1;
        end
        gerber(round_y, round_x + x) = polarity;
        gerber(round_y, round_x - x) = polarity;
        y = 1;
        x = x + 1;
    end
end


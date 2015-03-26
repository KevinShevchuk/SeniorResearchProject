function draw_line( prev_x, curr_x, prev_y, curr_y, curr_ad)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

global aper_def
global render_sf
global gerber

    draw_circle(prev_x, prev_y, curr_ad, 1);
    draw_circle(curr_x, curr_y, curr_ad, 1);
    diag_diam = (aper_def{curr_ad, 2}*0.7071067814)*render_sf; %radius of the aperture on diagonal. constant is based on the proportions on a right triangle.
    
%     rect = [(prev_x-radius)*sf, (prev_y-radius)*sf, aper_def{curr_ad, 2}*sf, aper_def{curr_ad, 2}*sf];
%     rectangle('Position',rect, 'Curvature', [1,1], 'FaceColor', 'r', 'EdgeColor', 'none')
%     rect = [(curr_x-radius)*sf, (curr_y-radius)*sf, aper_def{curr_ad, 2}*sf, aper_def{curr_ad, 2}*sf];
%     rectangle('Position',rect, 'Curvature', [1,1], 'FaceColor', 'r', 'EdgeColor', 'none')

    if (prev_x == curr_x) % Line is vertical
        start_x = round((prev_x-(aper_def{curr_ad, 2}/2))*render_sf);
        end_x = round((curr_x-(aper_def{curr_ad, 2}/2))*render_sf) + (aper_def{curr_ad, 2}*render_sf);
        if (prev_y < curr_y) % Line draws downwards.
            start_y = round(prev_y*render_sf);
            end_y = round(curr_y*render_sf);
        else %line draws upwards
            start_y = round(curr_y*render_sf);
            end_y = round(prev_y*render_sf);
        end
        
        for (i = start_x:end_x)
            for (j = start_y:end_y)
                gerber(j, i) = 1;
            end
        end
        
    elseif (prev_y == curr_y) % Line is horizontal
        start_y = round((prev_y-(aper_def{curr_ad, 2}/2))*render_sf);
        end_y = round((curr_y-(aper_def{curr_ad, 2}/2))*render_sf) + (aper_def{curr_ad, 2}*render_sf);
        if (prev_x < curr_x) % Line draws downwards.
            start_x = round(prev_x*render_sf);
            end_x = round(curr_x*render_sf);
        else %line draws upwards
            start_x = round(curr_x*render_sf);
            end_x = round(prev_x*render_sf);
        end
        
        for (i = start_x:end_x)
            for (j = start_y:end_y)
                gerber(j, i) = 1;
            end
        end
    else % Draw Diagonals.       
        if (prev_x < curr_x) && (prev_y < curr_y) % Draw SE Direction lines.
            start_x = round((prev_x*render_sf)+(diag_diam/2));
            start_y = round((prev_y*render_sf)-(diag_diam/2));
            l_end_x = round((curr_x*render_sf)+(diag_diam/2));   
            iterations = abs(l_end_x - start_x)-1;
            offset = 0;
            k = 0;
            i = start_x;
            j = start_y;
            while (offset < diag_diam)
                for k = 0:iterations
                    gerber(j, i) = 1;
                    j = j + 1;
                    gerber(j, i) = 1;
                    i = i + 1;
                end
                offset = offset + 1;
                i = start_x - offset;
                j = start_y + offset;
            end
        elseif (prev_x < curr_x) && (prev_y > curr_y) % Draw NE Direction lines.
            start_x = round((prev_x*render_sf)-(diag_diam/2));
            start_y = round((prev_y*render_sf)-(diag_diam/2));
            l_end_x = round((curr_x*render_sf)-(diag_diam/2));   
            iterations = abs(l_end_x - start_x)-1;
            offset = 0;
            k = 0;
            i = start_x;
            j = start_y;
            while (offset < diag_diam)
                for k = 0:iterations
                    gerber(j, i) = 1;
                    j = j - 1;
                    gerber(j, i) = 1;
                    i = i + 1;
                end
                offset = offset + 1;
                i = start_x + offset;
                j = start_y + offset;
            end
        elseif (prev_x > curr_x) && (prev_y < curr_y) % Draw SW Direction Lines.
            start_x = round((prev_x*render_sf)+(diag_diam/2));
            start_y = round((prev_y*render_sf)+(diag_diam/2));
            l_end_x = round((curr_x*render_sf)+(diag_diam/2));   
            iterations = abs(l_end_x - start_x)-1;
            offset = 0;
            k = 0;
            i = start_x;
            j = start_y;
            while (offset < diag_diam)
                for k = 0:iterations
                    gerber(j, i) = 1;
                    j = j + 1;
                    gerber(j, i) = 1;
                    i = i - 1;
                end
                offset = offset + 1;
                i = start_x - offset;
                j = start_y - offset;
            end
        elseif (prev_x > curr_x) && (prev_y > curr_y)
            start_x = round((prev_x*render_sf)-(diag_diam/2));
            start_y = round((prev_y*render_sf)+(diag_diam/2));
            l_end_x = round((curr_x*render_sf)-(diag_diam/2));   
            iterations = abs(l_end_x - start_x)-1;
            offset = 0;
            k = 0;
            i = start_x;
            j = start_y;
            while (offset < diag_diam)
                for k = 0:iterations
                    gerber(j, i) = 1;
                    j = j - 1;
                    gerber(j, i) = 1;
                    i = i - 1;
                end
                offset = offset + 1;
                i = start_x + offset;
                j = start_y - offset;
            end
        else
            disp('Unrecognized Shape Detected')
        end
    end

%     if (prev_x == curr_x) % Line is vertical
%         x_vector = [(prev_x+radius)*sf (prev_x-radius)*sf (curr_x-radius)*sf (curr_x+radius)*sf];
%         y_vector = [prev_y*sf prev_y*sf curr_y*sf curr_y*sf];
%     elseif (prev_y == curr_y) % Line is horizontal
%         x_vector = [prev_x*sf prev_x*sf curr_x*sf curr_x*sf];
%         y_vector = [(prev_y+radius)*sf (prev_y-radius)*sf (curr_y-radius)*sf (curr_y+radius)*sf]; 
%     else % Diagonals
%         if (prev_x < curr_x) && (prev_y < curr_y)
%             x_vector = [(prev_x+diag_radius)*sf (prev_x-diag_radius)*sf (curr_x-diag_radius)*sf (curr_x+diag_radius)*sf];
%             y_vector = [(prev_y-diag_radius)*sf (prev_y+diag_radius)*sf (curr_y+diag_radius)*sf (curr_y-diag_radius)*sf];
%         elseif (prev_x > curr_x) && (prev_y < curr_y)
%             x_vector = [(prev_x+diag_radius)*sf (prev_x-diag_radius)*sf (curr_x-diag_radius)*sf (curr_x+diag_radius)*sf];
%             y_vector = [(prev_y+diag_radius)*sf (prev_y-diag_radius)*sf (curr_y-diag_radius)*sf (curr_y+diag_radius)*sf];
%         elseif (prev_x > curr_x) && (prev_y > curr_y)
%             x_vector = [(prev_x+diag_radius)*sf (prev_x-diag_radius)*sf (curr_x-diag_radius)*sf (curr_x+diag_radius)*sf];
%             y_vector = [(prev_y-diag_radius)*sf (prev_y+diag_radius)*sf (curr_y+diag_radius)*sf (curr_y-diag_radius)*sf];
%         elseif (prev_x < curr_x) && (prev_y > curr_y)
%             x_vector = [(prev_x-diag_radius)*sf (prev_x+diag_radius)*sf (curr_x+diag_radius)*sf (curr_x-diag_radius)*sf];
%             y_vector = [(prev_y-diag_radius)*sf (prev_y+diag_radius)*sf (curr_y+diag_radius)*sf (curr_y-diag_radius)*sf];
%         else
%             error('Unrecognized Shape Detected')
%         end
%     end
%     
%     handle = patch(x_vector, y_vector, [1 0 0]);
%     set(handle, 'EdgeColor', 'none');
%     hold off
end
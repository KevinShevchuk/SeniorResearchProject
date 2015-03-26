function draw_rect(curr_x, curr_y, curr_ad)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

global aper_def
global gerber
global render_sf

    start_x = round((curr_x-(aper_def{curr_ad, 2}/2))*render_sf);
    start_y = round((curr_y-(aper_def{curr_ad, 3}/2))*render_sf);
    width = round(aper_def{curr_ad, 2}*render_sf);
    height = round(aper_def{curr_ad, 3}*render_sf);
    
    for (i = start_x:start_x+width)
        for (j = start_y:start_y+height)
            gerber(j, i) = 1;
        end
    end

%     if (aper_def{curr_ad, 1} == 'R')
%         hold on
%         rect = [(curr_x-(aper_def{curr_ad, 2}/2))*sf, (curr_y-(aper_def{curr_ad, 3}/2))*sf, aper_def{curr_ad, 2}*sf, aper_def{curr_ad, 3}*sf];
%         rectangle('Position',rect, 'FaceColor', 'r', 'EdgeColor', 'none')
%         hold off
%     elseif (aper_def{curr_ad, 1} == 'C') % Midpoint Circle Algorithm.              
%         hold on
%         rect = [(x-(aper_def{ad, 2}/2))*sf, (y-(aper_def{ad, 2}/2))*sf, aper_def{ad, 2}*sf, aper_def{ad, 2}*sf];
%         rectangle('Position',rect, 'Curvature', [1,1], 'FaceColor', 'r', 'EdgeColor', 'none')
%         hold off
%     elseif (aper_def{curr_ad, 1} == 'O')
%         hold on
%         rect = [(curr_x-(aper_def{curr_ad, 2}/2))*sf, (curr_y-(aper_def{curr_ad, 3}/2))*sf, aper_def{curr_ad, 2}*sf, aper_def{curr_ad, 2}*sf];
%         rectangle('Position',rect, 'Curvature', [1], 'FaceColor', 'r', 'EdgeColor', 'none')
%         hold off
%     else
%         error('Unhandled Shape Detected')
%     end
       
end


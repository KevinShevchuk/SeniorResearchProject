function function_handles = axes_zoom( handles, zoom_scale )
% the following function is derived from Scott Smith, author of "MATLAB: Advanced
% GUI Development" for use in this project.

%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    xlim = get(handles.axes_main, 'XLim');
    xmax = xlim(2);
    xmin = xlim(1);
    x = handles.mouse_pos(1, 1);
    
    ylim = get(handles.axes_main, 'YLim');
    ymax = ylim(2);
    ymin = ylim(1);
    y = handles.mouse_pos(1, 2);
    
    sx_zoom = zoom_scale;
    xmax_zoom = (xmax - x)*sx_zoom+x;
    xmin_zoom = (xmin - x)*sx_zoom+x;
    set(handles.axes_main, 'XLim', [xmin_zoom xmax_zoom]);
    
    sy_zoom = zoom_scale;
    ymax_zoom = (ymax - y)*sy_zoom+y;
    ymin_zoom = (ymin - y)*sy_zoom+y;
    set(handles.axes_main, 'YLim', [ymin_zoom ymax_zoom]);
end


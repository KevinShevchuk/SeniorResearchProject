function [ c_x, c_y ] = center_circle( x, y )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

global drl_holes
    x_arr = drl_holes(1,:);
    d = x_arr - x;
    b = abs(d);
    [b p] = min(b);
        
    y_arr = drl_holes(2,:);
    d = y_arr - y;
    b = abs(d);
    [b q] = min(b);
    
    c_x = drl_holes(1, p)  
    c_y = drl_holes(2, q)
end


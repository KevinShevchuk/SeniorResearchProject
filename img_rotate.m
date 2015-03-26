function dest = img_rotate(rotate)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

global rgb_gerber
global rgb_source
global x_offset
global y_offset
global rotation

    rotate = rotate * (pi/180);
    rotation = rotation + rotate; % add new rotation value to previous.
    
    [M, N, O] = size(rgb_gerber);
    tform = maketform('affine', [cos(rotation) -sin(rotation) 0;...
        sin(rotation) cos(rotation) 0; x_offset y_offset 1]);   
    moving_reg = imtransform(rgb_source, tform,...
        'XData', [1 N], 'YData', [1 M], ...
        'Size', [M N]);
    dest = imfuse(moving_reg, rgb_gerber);

end


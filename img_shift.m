function dest = img_shift(move_x, move_y)
% Performs image registration

global rgb_gerber
global rgb_source
global x_offset
global y_offset
global rotation

    x_offset = move_x + x_offset;
    y_offset = move_y + y_offset;

    [M, N, O] = size(rgb_gerber);
    tform = maketform('affine', [cos(rotation) -sin(rotation) 0;...
        sin(rotation) cos(rotation) 0; x_offset y_offset 1]);    
    moving_reg = imtransform(rgb_source, tform,...
        'XData', [1 N], 'YData', [1 M], ...
        'Size', [M N]);
    dest = imfuse(moving_reg, rgb_gerber);

%     
%     dest = rgb_source; % Make a new destination image.
% 
%     x_offset = move_x + x_offset;
%     y_offset = move_y + y_offset;
% 
%     [x, y, z] = size(rgb_source);
%     [p, q, r] = size(rgb_gerber);
%     
%     if (x > p)
%         x_bounds = p;
%     else
%         x_bounds = x;
%     end
%     if (y > q)
%         y_bounds = q;
%     else
%         y_bounds = y;
%     end
%     
%     src_x = 1;
%     if (x_offset < 0)
%         src_x = 1 + abs(x_offset);
%     end
%     
%     for i = x_offset+1:(x_bounds)
%         src_y = 1;
%         if (x_offset < 0)
%             src_y = 1 + abs(y_offset);
%         end
%         if (src_x == x_bounds)
%             break;
%         end
%         for j = y_offset+1:(y_bounds)
%             if (src_y == y_bounds)
%                 break;
%             end
%             for k = 1:3 %iterate through rgb
%                 src_pixel = rgb_source(i - x_offset, j - y_offset, k);
%                 gerb_pixel = rgb_gerber(src_x, src_y, k);
%                 dest_pixel = src_pixel + gerb_pixel;
%                 dest(src_x, src_y, k) = dest_pixel;
%                 % If src_x = p or x break both inner loops.
%             end
%             src_y = src_y + 1;
%         end
%         src_x = src_x + 1;
%     end       
    
    %dest = imfuse(rgb_source, rgb_gerber);
    
    %resize the image. This becomes obsolete when the core drawing is
    %redone.
%     [x,y] = size(board);
%     sized = imresize(base, [dimy*render_sf, dimx*render_sf]);
%     bin = im2bw(sized, .1);
%     base = im2double(bin);
%     imwrite(base, 'board1.png');
    
%     optimizer = registration.optimizer.RegularStepGradientDescent();
%     metric = registration.metric.MeanSquares;
%     
%     optimizer.MinimumStepLength = 5e-4;
%     optimizer.MaximumIterations = 200;
%     optimizer.GradientMagnitudeTolerance = 1e-4;
%     optimizer.MaximumStepLength = .02;
%     optimizer.RelaxationFactor = .05;

%     optimizer = registration.optimizer.OnePlusOneEvolutionary;
%     metric = registration.metric.MattesMutualInformation;
%     
%     optimizer.InitialRadius = .0009;
%     optimizer.Epsilon = 1.5e-7;
%     optimizer.GrowthFactor = 1.01;
%     optimizer.MaximumIterations = 500;
    
%     moving_reg = imregister(board, gerber, 'similarity', optimizer, metric, 'PyramidLevels', 1);
%     h = cpselect(moving, fixed);
%     waitfor(h);
%     disp(base_points)
%     disp(input_points)
%     if (test_debug_flag == 1)
%         disp('Application has completed successfully')
%     end
%     tform = fitgeotrans(input_points, base_points, 'projective');
%     registered = imwarp(moving, tform);
%     figure
%     imshowpair(gerber, moving_reg);
% =======THIS WORKS!=====
% src_x = 1;
%     for i = x_offset+1:(x_bounds)
%         src_y = 1;
%         for j = y_offset+1:(y_bounds)
%             for k = 1:3 %iterate through rgb
%                 gerb_pixel = rgb_gerber(i - x_offset, j - y_offset, k);
%                 src_pixel = rgb_source(src_x, src_y, k);
%                 dest_pixel = src_pixel + gerb_pixel;
%                 dest(src_x, src_y, k) = dest_pixel;
%             end
%             src_y = src_y + 1;
%         end
%         src_x = src_x + 1;
%     end       
%=========================
end


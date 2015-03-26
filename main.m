function main()
%Main runner for the program.

close all
clc
clear all
    
global test_debug_flag
global drill_present
global gerb_present
global gerber
global source_binary
global rgb_gerber
global rgb_source
global render_sf

    test_debug_flag = 0; % Toggles debug output. one for on, zero for off.
    drill_present = 0;
    gerb_present = 0;
    
%     prompt = 'Enter gerber filename: ';
%     file_name_gerber = input(prompt, 's');
%     prompt = 'Enter drill filename: ';
%     file_name_drill = input(prompt, 's');
% 
%     line_count = gerb_file_io(file_name_gerber);
%     [dim_x, dim_y] = gerb_preproc(line_count); % Preprocess the file data.
%     draw_board(line_count, dim_x, dim_y);
%     line_count = drl_file_io(file_name_drill);
%     drl_preproc(line_count, dim_x, dim_y);
%     draw_drl(line_count, dim_x, dim_y);
%     imshow(gerber);
   
    h = launch_gui;
    uiwait(h);
    
    %print(source_binary, '-dpng', 'src.png', '-r1200');
    
    h = cp_gui;
    uiwait(h);
    
    rgb_gerber = bw2rgb(gerber);
    rgb_gerber = padarray(rgb_gerber, [100, 100]);
    rgb_gerber(:,:,2) = 0;
    rgb_source = bw2rgb(source_binary);
    rgb_source(:,:,1) = 0;
    rgb_source(:,:,3) = 0;

    g = ir_gui;
    uiwait(g);
    
    %Handle file I/O on the Gerber File.
%     prompt = 'Enter gerber filename: ';
%     file_name_gerber = input(prompt, 's');
%     prompt = 'Enter board image filename: ';
%     file_name_source = input(prompt, 's');
    %prompt = 'Enter the DPI of the image: ';
    %render_sf = input(prompt, 'i');
    
%     %Process the Gerber file.
%     disp('Rendering Gerber File...')
%     line_count = file_io(file_name_gerber);
%     [dim_x, dim_y] = gerb_preproc(line_count); % Preprocess the file data.
%     draw_board(line_count, dim_x, dim_y);
%     disp('Rendering Complete.')
%     
% %     fig = figure(1);
% %     set(fig, 'Visible', 'off');
% %     disp('Saving image...')
% %     print(fig, '-dpng', 'board1.png', '-r600');
% %     disp('Image saved.')
%     
%     % Process scanned image.
%     disp('Processing Scanned-in Image...')
%     [moving] = img_process(file_name_source);
%     disp('Processing Complete.')
%     
%     % Image Registration
%     [reg_img, base_img] = imgreg(moving, dim_x, dim_y);
    
    if (test_debug_flag == 1)
        disp('Application has completed successfully')
    end
end
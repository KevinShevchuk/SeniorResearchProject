function untitled()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    prompt = 'Enter board image filename: ';
    file_name = input(prompt, 's');
    img = imread(file_name);
    [x, y, z] = size(img);
    binary_img = zeros(x, y);
    
    for i = 1:x
        for j = 1:y
            if (img(i,j,1) > img(i,j,2)+21)
                binary_img(i, j) = 1;
            elseif (img(i,j,1) > img(i,j,2)+15)
                if (img(i,j,2) < img(i,j,3)+30)
                    binary_img(i, j) = 1;
                end
            end
        end
    end
    
    filtered = medfilt2(binary_img, [3, 3]);
    se = strel('diamond', 2);
    closed = imclose(filtered, se);
    
    imshow(closed)
end


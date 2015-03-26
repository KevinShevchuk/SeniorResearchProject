function [ c_x, c_y ] = centroid_blob( x, y )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global source_binary

    limit = 50;
    done = 0;
    ex_fact = 3;
    while done ~= 8; %when all 9 testing points are detected as copper.

        matrix = source_binary(y-ex_fact:y+ex_fact, x-ex_fact:x+ex_fact);
        if (matrix(1, 1) == 1);
            done = done + 1;
        end
        if (matrix(1, ex_fact) == 1);
            done = done + 1;
        end
        if (matrix(1, 2*ex_fact) == 1);
            done = done + 1;
        end
        if (matrix(ex_fact, 2*ex_fact) == 1);
            done = done + 1;
        end
        if (matrix(2*ex_fact, 2*ex_fact) == 1);
            done = done + 1;
        end
        if (matrix(2*ex_fact, ex_fact) == 1);
            done = done + 1;
        end
        if (matrix(2*ex_fact, 1) == 1);
            done = done + 1;
        end
        if (matrix(ex_fact, 1) == 1);
            done = done + 1;
        end

        %adjust expansion factor based on number of hits.
        if (done == 8)
            [c_x, c_y] = find_centroid(matrix);
            c_x = c_x + round(x-ex_fact);
            c_y = c_y + round(y-ex_fact);
            break;
        elseif (done < 8) && (done >= 6)
            ex_fact = ex_fact + 1;
        elseif (done < 6) && (done >= 4)
            ex_fact = ex_fact + 2;
        else
            ex_fact = ex_fact + 3;
        end
        done = 0;

        if (ex_fact > limit)
            error('Testing Limit exceeded');
        end
    end
end
    
function [ x, y ] = find_centroid( matrix )
    figure(1);
    imshow(matrix);
    [m, n] = size(matrix);
    x_sum = 0;
    ind = 1;
    count = 0;
    for (i = 1:m)
        for (j = 1:n)
            if (matrix(i, j) == 0)
                count = count + 1;
                x_sum = x_sum + j; 
            end
        end
        x_sum = x_sum / count;
        if (count ~= 0)
            row_average(ind) = x_sum;
            ind = ind + 1;
        end
        count = 0;
        x_sum = 0;
    end
    
    ind = 1;
    count = 0;
    y_sum = 0;
    for (i = 1:m)
        for (j = 1:n)
            if (matrix(j, i) == 0)
                count = count + 1;
                y_sum = y_sum + j;
            end
        end
        y_sum = y_sum / count;
        if (count ~= 0)
            col_average(ind) = y_sum;
            ind = ind + 1;
        end
        count = 0;
        y_sum = 0;
    end
    a = sum(row_average);
    [o, b] = size(row_average);
    x = a/b;
    a = sum(col_average);
    [o, b] = size(col_average);
    y = a/b;
end


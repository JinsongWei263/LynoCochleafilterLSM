function spiketrain = BSA(A, x, threshold)
    
    spiketrain = zeros(size(x));
    for i = 1 : size(x, 2)
        error1 = zeros(size(x,1), 1);
        error2 = zeros(size(x,1), 1);
        for j = 1  : length(A)
            if i+j-1 <= size(x, 2)
                error1 = error1 + abs(x(:, i+j-1) - A(j));
                error2 = error2 + abs(x(:, i+j-1));
            else
                break;
            end
        end

        spiketrain(:,i) = error1<=(error2 - threshold);
        for j  = 1 : length(A)
            if i+j-1 <= size(x, 2)
                x(:, i+j-1) = x(:, i+j-1) - A(j) * spiketrain(:, i);
            else 
                break;
            end
        end
    end
    
end
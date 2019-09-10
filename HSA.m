function spiketrain = HSA(A, x)
    
    spiketrain = zeros(size(x));
    for i = 1 : size(x, 2)
        count = zeros(size(x,1), 1);
        for j = 1  : length(A)
            if i+j-1 <= size(x, 2)
                count = count + (x(:,i+j-1)>=A(j));
            else
                break;
            end
        end
        
        spiketrain(:,i) = count == length(A);
        for j  = 1 : length(A)
            if i+j-1 <= size(x, 2)
                x(:, i+j-1) = x(:, i+j-1) - A(j) * spiketrain(:, i);
            else 
                break;
            end
        end
    end
    
end
function nn = nnbp(nn)
%NNBP performs backpropagation
% nn = nnbp(nn) returns an neural network structure with updated weights 
    
    n = nn.n;
 
    d{n} = - nn.e .* nn.a{n} .* (1 - nn.a{n});
    d{n} = grad_fg(d{n},nn.bitG);
    
    for i = (n - 1) : -1 : 2
        % Derivative of the activation function
        d_act = nn.a{i}.*(1-nn.a{i});
        
        % Backpropagate first derivatives
        
        if i+1==n % in this case in d{n} there is not the bias term to be removed             
            d{i} = (d{i + 1} * nn.Wb{i}) .* d_act; % Bishop (5.56)
        else % in this case in d{i} the bias term has to be removed
            d{i} = (d{i + 1}(:,2:end) * nn.Wb{i}) .* d_act;
        end
        d{i} = grad_fg(d{i},nn.bitG);
    end

    for i = 1 : (n - 1)
        if i+1==n
            nn.dW{i} = (d{i + 1}' * nn.a{i}) / size(d{i + 1}, 1);
        else
            nn.dW{i} = (d{i + 1}(:,2:end)' * nn.a{i}) / size(d{i + 1}, 1);      
        end
    end
end

function nn = nnapplygrads(nn)
%NNAPPLYGRADS updates weights and biases with calculated gradients
% nn = nnapplygrads(nn) returns an neural network structure with updated
% weights and biases
    for i = 1 : (nn.n - 1)
        dW = nn.dW{i} .* (1-nn.W{i}.^2)/max(abs(nn.W{i}(:)));        
        dW = nn.learningRate * dW;                    
        nn.W{i} = nn.W{i} - dW;
    end
end

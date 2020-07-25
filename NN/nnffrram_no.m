function nn = nnffrram_no(nn, x, y)
%NNFF performs a feedforward pass
% nn = nnff(nn, x, y) returns an neural network structure with updated
% layer activations, error and loss (nn.a, nn.e and nn.L)

    n = nn.n;
    m = size(x, 1);
    
    x = [ones(m,1) x];
    nn.a{1} = x;

    %feedforward pass
    for i = 2 : n-1

        nn.Wb{i-1}  = fwrram_no(nn.W{i-1},nn.rram);
        nn.a{i}     = sigm(nn.a{i-1} * nn.Wb{i-1}');
        nn.a{i}     = fa(nn.a{i},nn.bitA);
        %Add the bias term
        nn.a{i} = [ones(m,1) nn.a{i}];
    end

    nn.Wb{n-1}      = fwrram_no(nn.W{n-1},nn.rram);
    nn.a{n}         = nn.a{n-1} * nn.Wb{n-1}';
%     nn.a{n}         = sigm(nn.a{n});
    nn.a{n}         = softmax(nn.a{n});
    %error and loss
    nn.e = y - nn.a{n};
    
    nn.L = 1/2 * sum(sum(nn.e .^ 2)) / m;
end

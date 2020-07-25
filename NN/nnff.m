function nn = nnff(nn, x, y)
%NNFF performs a feedforward pass
% nn = nnff(nn, x, y) returns an neural network structure with updated
% layer activations, error and loss (nn.a, nn.e and nn.L)
if strcmp(nn.fftype,'nnff')
    n = nn.n;
    m = size(x, 1);
    
    x = [ones(m,1) x];
    nn.a{1} = x;

    %feedforward pass
    for i = 2 : n-1

        nn.Wb{i-1}  = fw(nn.W{i-1},nn.bitW);
        nn.a{i}     = sigm(nn.a{i-1} * Wb{i-1}');
        nn.a{i}     = fa(nn.a{i},nn.bitA);
        %Add the bias term
        nn.a{i} = [ones(m,1) nn.a{i}];
    end

    nn.Wb{n-1}      = fw(nn.W{n-1},nn.bitW);
    nn.aa{n}         = nn.a{n-1} * nn.Wb{n-1}';
    nn.aa{n}        = nn.aa{n} .* (nn.aa{n}>0);
    nn.a{n}         = softmax(nn.aa{n});
    if find(isnan(nn.a{n}))
        nn.aa{n}
        nn.a{n}
        stop(0);
    end
%     nn.a{n}         = sigm(nn.a{n});
%     nn.a{n} = sigmrnd(nn.a{n});

    %error and loss
    nn.e = y - nn.a{n};
    
    nn.L = 1/2 * sum(sum(nn.e .^ 2)) / m;
elseif strcmp(nn.fftype,'nnffrram')
    nn = nnffrram(nn, x, y);
elseif strcmp(nn.fftype,'nnffrram_no')
    nn = nnffrram_no(nn, x, y);
end
end

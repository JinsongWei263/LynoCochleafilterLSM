function [y, state] = agc(x, target, epsilon)
    EPS = 1e-1;
    stateLimit = 1-EPS;
    oneMinusEpsOverThree = (1 - epsilon)/3.0;
    epsOverTarget = epsilon ./ target;
    
    [channel, n] = size(x);
    y = zeros(size(x));
    for c = 1 : channel 
        for i = 1 : n 
            y(c, i) = 
        end
    end
end
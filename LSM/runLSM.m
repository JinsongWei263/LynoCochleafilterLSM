function [lsm, spikeout] = runLSM(lsm, spikein)
    
    m = size(spikein, 2);
    ni = size(spikein,1);
    n = lsm.n;
%     spikeout = zeros(1, floor(n/2));
    spikeout = zeros(1, n);    
    lsm.t = ones(size(lsm.t))*(lsm.tf+1);
    lsm.is = zeros(1,n);
    for i = 1 : m 
        lsm.v = lsm.v - lsm.v / lsm.tm;

        lsm.v(1:n) = lsm.v(1:n) + spikein(:,i)' * lsm.Win;

        lsm.v = lsm.v + lsm.v * lsm.W .* (lsm.t>lsm.tf);
        lsm.s = (lsm.v > lsm.vth) .* (lsm.t>lsm.tf);

        lsm.t = lsm.t + (lsm.t<=lsm.tf);
        lsm.v = lsm.v .* (1-lsm.s);
        lsm.t = lsm.t .* (1-lsm.s);

        lsm.is = (lsm.s.*(1-lsm.e)*lsm.C)>=1;

        lsm.s = lsm.s .* lsm.is;
        
        spikeout = spikeout + lsm.s(1 : end);
    end
    spikeout = spikeout / m;
end
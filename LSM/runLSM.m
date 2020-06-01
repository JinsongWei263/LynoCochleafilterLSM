function [lsm, spikeout] = runLSM(lsm, spikein)
    
    t = size(spikein, 2);
    ni = size(spikein,1);
    n = lsm.n;
    m = lsm.m;
    lsm.t = ones(size(lsm.t))*(lsm.tf+1);
    lsm.s = zeros(1,m);
    lsm.v = zeros(1,m);
    spikeout = zeros(t,m);
    for i = 1 : t
        lsm.v = lsm.v - lsm.v / lsm.tm;
        lsm.v = lsm.v + spikein(:,i)'* lsm.Win .*(lsm.t>lsm.tf);
        lsm.v = lsm.v + lsm.s * lsm.W .* (lsm.t>lsm.tf);
        
        lsm.s = (lsm.v >= lsm.vth) .* (lsm.t>lsm.tf);
        lsm.t = lsm.t + (lsm.t<=lsm.tf);
        lsm.v = lsm.v .* (1-lsm.s);
        lsm.t = lsm.t .* (1-lsm.s);

%         lsm.is = (lsm.s.*(1-lsm.e)*lsm.C)>=2;
%         lsm.s = lsm.s .* (1-lsm.is);
        spikeout(i,:) = lsm.s(1,:);
    end
end
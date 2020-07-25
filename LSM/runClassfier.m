function [snn, spikeout] = runClassfier(nn, lsm, spikein)

    time = size(spikein, 1);
    snn = nn;
    
    for i= 1 : snn.n-1
        snn.W{i} = fwrram_no(nn.W{i}, nn.rram)/nn.rram_scale;
        snn.t{i} = ones(1,snn.size(i+1))*(lsm.tf+1);
        snn.s{i} = zeros(1,snn.size(i+1));
        snn.v{i} = zeros(1,snn.size(i+1));
    end
    spikeout = zeros(time, snn.size(snn.n));
    snn_network = false;

    for t = 1 : time
        snn.a{1} = [1,spikein(t,:)];
        for i = 1 : snn.n-1
            if (snn_network)
                snn.v{i} = snn.v{i} - snn.v{i}/lsm.tm;
                snn.v{i} = snn.v{i} + snn.a{i} * snn.W{i}'.*(snn.t{i}>lsm.tf);
                snn.s{i} = (snn.v{i}>=lsm.vth) .* (snn.t{i}>lsm.tf);
                snn.t{i} = snn.t{i} + (snn.t{i}<=lsm.tf);
                snn.v{i} = snn.v{i} .* (1-snn.s{i});
                snn.t{i} = snn.t{i} .* (1-snn.s{i});
                snn.a{i+1} = snn.s{i};
            else 
                snn.v{i} = snn.v{i} + snn.a{i} * snn.W{i}';
                snn.s{i} = (snn.v{i}>=lsm.vth);
                snn.v{i} = snn.v{i} - lsm.vth*snn.s{i};
                snn.a{i+1} = snn.s{i};
            end
        end
        spikeout(t,:) = snn.a{snn.n}(1,:);
    end
end

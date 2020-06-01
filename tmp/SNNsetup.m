function snn = SNNsetup(architecture, opt)
    snn.size = architecture;
    snn.n =  numel(snn.size);
    snn.vth = opt.vth;
    snn.learnrate = opt.learnrate;
    for i = 1 : n
        snn.s{i} = zeros(1,snn.size(i));
        snn.v{i} = zeros(1,snn.size(i));
        snn.trf{i} = ones(1,snn.size(i))*snn.vth;
        snn.x{i} = zeros(1,snn.size(i));
    end
    for i = 2 : n
        snn.w{i-1} = rand(snn.size(i-1)+1, snn.size(i))*10;
    end
end
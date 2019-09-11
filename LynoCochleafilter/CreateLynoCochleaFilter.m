function [earfilter, cf] = CreateLynoCochleaFilter(opt)
   
%% cascadecf
index = 1;
cf = [];
while(true)
    cascadecf = EarChannelCF(index, opt);
    index = index + 1;
    if (cascadecf < 63)
        break;
    end
    cf = [cf, cascadecf];
end

cascadezerocf = CascadeZeroCF(cf, opt);
cascadezeroq = CascadeZeroQ(cf, opt);
cascadepolecf = CascadePoleCF(cf, opt);
cascadepoleq = CascadePoleQ(cf, opt);

%% Outer, Middle Ear Filter and Ear Front Filter
unitfilter.B = [1];
unitfilter.A = [1];
unitfilter.G = 1;

pf = FirstOrderFromCorner(opt.EarPremphCorner, opt.Fs);
outermiddleearfillter = MakeFilter(FirstOrderFromCorner(opt.EarPremphCorner, opt.Fs), ...
                        unitfilter, 0, opt.Fs, 1.0);

tfilter.B = [1,0,-1];
tfilter.A = [1];
tfilter.G = 1;
compenstator = MakeFilter(tfilter, unitfilter, opt.Fs/4, opt.Fs, 1);
earfrontfilter = CascadeFilter(outermiddleearfillter, compenstator);

prefirststagefilter = SecondOrderFromCenterQ( cascadepolecf(1), cascadepoleq(1), opt.Fs);
earfrontfilter = CascadeFilter(earfrontfilter,  MakeFilter(unitfilter, prefirststagefilter, ...
                                                        opt.Fs/4, opt.Fs, 1.0));
earfrontfilter.G = real(earfrontfilter.G);
%% Ear Stage Filter

earfilter = [earfrontfilter];
dcgain = cf(1:end-1) ./ cf(2:end);
for i = 2 : length(cascadezerocf)
    earstagefilter = MakeFilter( SecondOrderFromCenterQ(cascadezerocf(i), cascadezeroq(i), opt.Fs), ...
                                 SecondOrderFromCenterQ(cascadepolecf(i), cascadepoleq(i), opt.Fs), ...
                                 0.0, opt.Fs, ...
                                 dcgain(i-1));
    earfilter = [earfilter, earstagefilter];
end

end
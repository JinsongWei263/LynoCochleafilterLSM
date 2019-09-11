function poleq = CascadePoleQ(cf, opt)
    poleq = cf ./ EarBandwidth(cf, opt);
end

function poleQ = OriginalPoleQ(cf, opt)
    poleQ = cf ./ EarBandwidth(cf, opt);
end
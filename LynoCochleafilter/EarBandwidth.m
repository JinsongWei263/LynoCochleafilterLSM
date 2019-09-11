function bandwdith = EarBandwidth(cf, opt)

    bandwdith = sqrt(cf.^2 + opt.EarBreakFreq.^2) ./ opt.EarQ ;

end
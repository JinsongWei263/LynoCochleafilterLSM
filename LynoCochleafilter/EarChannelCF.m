function cf = EarChannelCF(index, opt)
    cf = MaximumEarCF(opt);
    if (index > 1)
        cf = EarChannelCF(index-1, opt);
        cf = cf - opt.EarStepFactor * EarBandwidth(cf, opt);
    end
end

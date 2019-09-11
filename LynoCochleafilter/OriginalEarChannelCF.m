function cf = OriginalEarChannelCF(index, opt)
    cf = opt.Fs/2;
    if (index>1)
        cf = OriginalEarChannelCF(index-1, opt);
        cf = cf - opt.EarStepFactor .* EarBandwidth(cf, opt);
    end
end

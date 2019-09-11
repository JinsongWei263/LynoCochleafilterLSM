function cf = MaximumEarCF(opt)
    cf = opt.Fs/2;
    cf = cf - (CascadeZeroCF(cf, opt) - cf) + EarBandwidth(cf, opt) * opt.EarStepFactor;
end


function zerocf = CascadeZeroCF(cf, opt)
    zerocf = cf + EarBandwidth(cf, opt) .* opt.EarStepFactor .* opt.EarZeroOffset;
end

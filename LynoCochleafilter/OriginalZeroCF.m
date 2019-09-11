function zerocf = OriginalZeroCF(cf, opt)
    zerocf = cf + EarBandwidth(cf, opt) .* opt.EarStepFactor .* opt.OriginalEarZeroOffset;
end
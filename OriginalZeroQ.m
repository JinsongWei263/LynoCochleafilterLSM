function zeroQ = OriginalZeroQ(cf, opt)
    zeroQ = opt.OriginalEarSharpness .* OriginalZeroCF(cf, opt) ./ EarBandwidth(cf, opt);
    
end
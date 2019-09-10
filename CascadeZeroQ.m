function zeroq = CascadeZeroQ(cf, opt)
    zeroq = opt.EarSharpness .* CascadeZeroCF(cf, opt) ./ EarBandwidth(cf, opt);
end

function response = FreqResponse(mfilter, fs)
    w = [0 : pi/1000: pi];
    z = exp(w*1i);
    B = abs(polyval(mfilter.B(end:-1:1), z));
    A = abs(polyval(mfilter.A(end:-1:1), z));
    response = 20*log10(B./A);
end

function val = FilterEval(p, f, fs)
%FilterEval - Description
%
% Syntax: val = FilterEval(p, x)
%
% Long description
    w = exp(i*2*pi*f/fs);
    fb = polyval(p.B(end:-1:1), w);
    fa = polyval(p.A(end:-1:1), w);
    val =fb./fa; 
end

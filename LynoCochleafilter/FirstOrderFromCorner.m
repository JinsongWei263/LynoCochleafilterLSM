function F = FirstOrderFromCorner(f, fs)
    
    F.B = [1, -exp(-2*pi*f/fs)];
    F.A = [1];
    F.G = 1;

end
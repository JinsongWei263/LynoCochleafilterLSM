function F = InvFilter(f)
    F.B = f.A;
    F.A = f.B;
    F.G = 1./f.G;
end
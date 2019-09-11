function F  = SecondOrderFromcenterQ(f, q, fs)

    F.B = [];
    F.A = [1];
    F.G = 1;

    cft = f/fs;
    rho = exp(-pi*cft/q);
    theta = 2 * pi * cft *sqrt(1- 1/(4*q^2));
    F.B = [rho^2, -2*rho*cos(theta), 1];
    F.G = 1;
    
end

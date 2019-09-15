function lsm = LSM(opt)
    n = opt.n;
    r = opt.r;
    lsm.n = n;
    lsm.r = r;
    lsm.tm = opt.tm;
    lsm.tc = opt.tc;
    lsm.vth = opt.vth;
    lsm.tf = opt.tf;
    lsm.dt = opt.dt;
    lsm.isth = opt.isth;
    lsm.w = zeros(n,n);
    lsm.p = zeros(n,n);
    lsm.v = zeros(1,n);
    lsm.t = zeros(1,n);
    d = zeros(n,n);
    
    E = randn(1,n) >= 0.5;
    C = zeros(n,n);
    W = zeros(n,n);
    p = zeros(n,n);
    kee = opt.kee;
    kei = opt.kei;
    kie = opt.kie;
    kii = opt.kii;
    wee = opt.wee;
    wei = opt.wei;
    wie = opt.wie;
    wii = opt.wii;
    
    for i = 1 : n
        a = int32(i);
        x = a / 16;
        y = mod(a, 16) / 4;
        z = mod(y, 4);
        for j = 1 : n
            a = int32(j);
            xj = a / 16;
            yj = mod(a, 16) / 4;
            zj = mod(yj, 4);
            d(i,j) = double((x-xj)^2 + (y-yj)^2 + (z-zj)^2);
            if (E(i)==1 && E(j)==1)
                p(i,j) = kee * exp(-1*d(i,j)/r);
                C(i,j) = rand > p(i,j);
                W(i,j) = C(i,j) * wee;
            elseif (E(i)==1 && E(j)==0) 
                p(i,j) = kei * exp(-1 * d(i,j)/r);
                C(i,j) = rand > p(i,j);
                W(i,j) = C(i,j) * wei;
            elseif (E(i)==0 && E(j)==1) 
                p(i,j) = kie * exp(-1 * d(i,j)/r);
                C(i,j) = rand > p(i,j);
                W(i,j) = C(i,j) * wie * 0 ;
            elseif (E(i)==0 && E(j)==1) 
                p(i,j) = kii * exp(-1 *d(i,j)/r);
                C(i,j) = rand > p(i,j);
                W(i,j) = C(i,j) * wii * 0;
            end
        end
    end

    Win = zeros(n,n);

    for i = 1 : n
        if E(i)==1
            Win(i, i) = wee;
        else
            Win(i, i) = wei;
        end
    end

    lsm.e = E;
    lsm.d = d;
    lsm.p = p;
    lsm.C = C;
    lsm.W = W;
    lsm.Win = Win;
    for i = 1 : n
        lsmW(i,i) = 0;
        lsm.C(i,i) = 0;
    end
end
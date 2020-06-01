function lsm = LSM(opt)
    n = opt.n;
    r = opt.r;
    kx = opt.kx;
    ky = opt.ky;
    kz = opt.kz;
    m = kx*ky*kz;
    lsm.n = n;
    lsm.r = r;
    lsm.tm = opt.tm;
    lsm.tc = opt.tc;
    lsm.vth = opt.vth;
    lsm.tf = opt.tf;
    lsm.dt = opt.dt;
    lsm.W = zeros(m,m);
    lsm.p = zeros(m,m);
    lsm.v = zeros(1,m);
    lsm.t = zeros(1,m);
    lsm.kx = opt.kx;
    lsm.ky = opt.ky;
    lsm.kz = opt.kz;
    lsm.m = kx*ky*kz; 
    d = zeros(m,m);
    E = randn(1,m) >= 0.4;
    C = zeros(m,m);
    W = zeros(m,m);
    p = zeros(m,m);
    kee = opt.kee;
    kei = opt.kei;
    kie = opt.kie;
    kii = opt.kii;
    wee = opt.wee;
    wei = opt.wei;
    wie = opt.wie;
    wii = opt.wii;
    
%     assert((kx*ky*kz==n),'kx*ky*kz!=n');

    for i = 1 : m
        a = int32(i);
        x = a / (ky*kz);
        y = mod(a, (ky*kz));
        z = mod(y, kz);
        y = y / kz;
        for j = 1 : n
            a = int32(j);
            xj = a / (ky*kz);
            yj = mod(a, (ky*kz));
            zj = mod(yj, kz);
            yj = yj / kz;
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
                W(i,j) = C(i,j) * wie ;
            elseif (E(i)==0 && E(j)==0) 
                p(i,j) = kii * exp(-1 *d(i,j)/r);
                C(i,j) = rand > p(i,j);
                W(i,j) = C(i,j) * wii;
            end
        end
    end
    Win = zeros(n,m);
    i = 0;
    for j = 1 : m
        i = i + 1;
        if i>n
            i=1;
        end
        if E(j)==1
            Win(i,j) = wee;
        else
            Win(i,j) = wei;
        end
    end
%     for i = 1 : n
%         for j = 1 : m
%             if E(j)==1
%                 Win(i,j) = 1;
%             else
%                 Win(i,j) = 1;
%             end
%         end
%     end

    lsm.e = E;
    lsm.d = d;
    lsm.p = p;
    lsm.C = C;
    lsm.W = W;
    lsm.Win = Win;
    for i = 1 : m
        lsm.W(i,i) = 0;
        lsm.C(i,i) = 0;
    end
end
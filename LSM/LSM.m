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

    ckk = randperm(kz);
    for ci = 1 : kz
        cj = ckk(ci);
        for i = 1 : kx*ky
            
            for j = 1 : kx*ky
                pre = (ci-1)*kx*ky + i;
                post= (cj-1)*kx*ky + j;
                ix = int32(i) / ky;
                iy = i - ix*ky;
                jx = int32(j) / ky;
                jy = j - jx*ky;
                d(pre,post) =sqrt( double( (ci-cj)^2 + (ix-jx)^2 + (iy-jy)^2 ) );
                if (E(pre)==1 && E(post)==1) 
                    p(pre,post) = kee * exp(-1*d(pre,post)/r);
                    C(pre,post) = rand > p(pre,post);
                    W(pre,post) = C(pre,post) * wee;
                elseif (E(i)==1 && E(j)==0) 
                    p(pre,post) = kei * exp(-1 * d(pre,post)/r);
                    C(pre,post) = rand > p(pre,post);
                    W(pre,post) = C(pre,post) * wei;
                elseif (E(i)==0 && E(j)==1) 
                    p(pre,post) = kie * exp(-1 * d(pre,post)/r);
                    C(pre,post) = rand > p(pre,post);
                    W(pre,post) = C(pre,post) * wie ;
                elseif (E(i)==0 && E(j)==0) 
                    p(pre,post) = kii * exp(-1 *d(pre,post)/r);
                    C(pre,post) = rand > p(pre,post);
                    W(pre,post) = C(pre,post) * wii;
                end
            end
        end
    end
    Win = zeros(n, m);
    ink = zeros(1,kz);
    mn = ceil(m/n);
    mz = 1;
    mj = 1;
    for i = 1 : n
        if (mj+mn-1) <= kx*ky
            mj = mj + mn-1;
        else
            mz = mz + 1;
            if (mz>kz)
                mz = 1;
            end
            mj = 1+mn-1;
        end
        ink(i) = mz;
        for j = (mz-1)*kx*ky + mj-mn+1 : (mz-1)*kx*ky+mj
            if E(j)==1
                Win(i,j) = wee;
            else
                Win(i,j) = wei;
            end
        end
        mj = mj + 1;
    end
    
%     for i = 1 : m
%         a = int32(i);
%         x = a / (ky*kz);
%         y = mod(a, (ky*kz));
%         z = mod(y, kz);
%         y = y / kz;
%         for j = 1 : n
%             a = int32(j);
%             xj = a / (ky*kz);
%             yj = mod(a, (ky*kz));
%             zj = mod(yj, kz);
%             yj = yj / kz;
%             d(pre,post) = double((x-xj)^2 + (y-yj)^2 + (z-zj)^2);
%             
%             if (E(i)==1 && E(j)==1) 
%                 p(pre,post) = kee * exp(-1*d(pre,post)/r);
%                 C(pre,post) = rand > p(pre,post);
%                 W(pre,post) = C(pre,post) * wee;
%             elseif (E(i)==1 && E(j)==0) 
%                 p(pre,post) = kei * exp(-1 * d(pre,post)/r);
%                 C(pre,post) = rand > p(pre,post);
%                 W(pre,post) = C(pre,post) * wei;
%             elseif (E(i)==0 && E(j)==1) 
%                 p(pre,post) = kie * exp(-1 * d(pre,post)/r);
%                 C(pre,post) = rand > p(pre,post);
%                 W(pre,post) = C(pre,post) * wie ;
%             elseif (E(i)==0 && E(j)==0) 
%                 p(pre,post) = kii * exp(-1 *d(pre,post)/r);
%                 C(pre,post) = rand > p(pre,post);
%                 W(pre,post) = C(pre,post) * wii;
%             end
%         end
%     end
%     Win = zeros(n,m);
%     i = 0;
%     for j = 1 : m
%         i = i + 1;
%         if i>n
%             i=1;
%         end
%         if E(j)==1
%             Win(i,j) = wee;
%         else
%             Win(i,j) = wei;
%         end
%     end

    lsm.e = E;
    lsm.d = d;
    lsm.p = p;
    lsm.C = C;
    lsm.W = W;
    lsm.Win = Win;
    lsm.ckk = ckk;
    lsm.ink = ink;
    for i = 1 : m
        lsm.W(i,i) = 0;
        lsm.C(i,i) = 0;
    end
end
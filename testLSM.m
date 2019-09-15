%% BP Net
clear;
load wavlsm.mat;
load 'spike.mat';


lsmopt.n = 64;
lsmopt.r = 1;
lsmopt.tm = 16;
lsmopt.tc = 32;
lsmopt.tf = 2;
lsmopt.dt = 1;
lsmopt.vth = 20;
lsmopt.kee = 0.45;
lsmopt.kei = 0.3;
lsmopt.kie = 0.6;
lsmopt.kii = 0.15;
lsmopt.wee= 3;
lsmopt.wei= 38;
lsmopt.wie= 0;
lsmopt.wii= 0;
lsmopt.isth = 4;
lsm = LSM(lsmopt);

[lsm, lsmspike] = runLSM(lsm, spike);

m= size(lsmout,1);
k = 1;
train_x = double(lsmout(1 :k: end,:));
train_y = zeros(size(train_x,1),10);

ii = 0;
for i = 1 : k : m
    ii= ii + 1;
    for j = 1 : 10
        if j == label(i)+1
            train_y(ii, j) = 1;
        end
    end
end
[train_x, mu, sigma] = zscore(train_x);

rand('state', 0);
nn = nnsetup([64, 10]);
opts.numepochs = 1000;
opts.batchsize = 5;
[nn, L] = nntrain(nn, train_x, train_y, opts);
[er, bad] = nntest(nn, train_x, train_y);
assert(er< 0.08, "too big error");

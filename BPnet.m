clear;
load wavlsm.mat;

m= size(lsmout,1);
train_x = double(lsmout);
train_y = zeros(size(lsmout,1),10);

for i = 1 : m
    for j = 1 : 10
        if j == label(i)+1
            train_y(i, j) = 1;
        end
    end
end
[train_x, mu, sigma] = zscore(train_x);

rand('state', 0);
nn = nnsetup([32, 10]);
opts.numepochs = 100;
opts.batchsize = 10;
[nn, L] = nntrain(nn, train_x, train_y, opts);
[er, bad] = nntest(nn, train_x, train_y);
assert(er< 0.08, "too big error");

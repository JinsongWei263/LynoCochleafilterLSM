%% get data set
clear ;
load lsmout.mat

ti = int32(size(lsmout,2));
lsmtrain = lsmout(:,1:end);
mn = size(lsmtrain,1);
li = size(lsmtrain,2);
set_x = double(lsmtrain);
set_y = zeros(size(set_x,1),10);
[set_x, mu, sigma] = zscore(set_x);

for i = 1 : 1 : mn
    for j = 1 : 10
        if j == label(i)+1
            set_y(i, j) = 1;
        end
    end
end
%% create train set and test set
mtrain = floor(mn * 0.9);
mtest  = mn - mtrain;
kk = randperm(mn);
train_x = set_x(kk(1:mtrain),:);
train_y = set_y(kk(1:mtrain),:);
% [train_x, ~, ~] = zscore(train_x);
test_x = set_x(kk(mtrain+1:end),:);
test_y = set_y(kk(mtrain+1:end),:);

%% train and test
rand('state', 0);
nn = nnsetup([li, 32, 10]);
opts.numepochs = 100;
opts.batchsize = 100;
[nn, L] = nntrain(nn, train_x, train_y, opts);
[er, bad] = nntest(nn, test_x, test_y);
assert(er< 0.08, ['too big error : ', num2str(er*100),'%']);

%% train & test


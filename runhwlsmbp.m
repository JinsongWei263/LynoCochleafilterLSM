clear;

load lsmout.mat

hwlsmout = zeros(2000, lsm.m);
hwlabel = zeros(1,2000);
num = 0;
step = 1;

for i = 1 : step : 2000
    fod = fopen(['data/lsm_net/outspike/outspike',num2str(i),'.out'],'r');
    if fod < 0 
        continue ;
    end
    num = num+1;
    hwlsmout(num,:)=fscanf(fod,'%d');
    hwlabel(num) = label(i);    
    fclose(fod);
end

len = 700;

lsmtrain = hwlsmout(1:len, 1:end);
[lsmtrain, mu, sigma] = zscored(lsmtrain);
flowlabel = zeros(len,10);
mn = size(lsmtrain,1);
li = size(lsmtrain,2);
ii = 0;
for l = 1 : mn
    for j = 1 : 10
        if j == hwlabel(l)+1
            flowlabel(l, j) = 1;
        end
    end
end
train_x = double(lsmtrain);
train_y = flowlabel;

rand('state', 0);
nn = nnsetup([li, 10]);
opts.numepochs = 100;
opts.batchsize = 10;
[nn, L] = nntrain(nn, train_x, train_y, opts);
[er, bad] = nntest(nn, train_x, train_y);
if (er < 0.08)
    disp(['too small error : ', num2str(er*100),'%']);
    save('net.mat', 'lsm', 'earfilter');
else
    disp(['enough big error : ', num2str(er*100),'%']);
end          


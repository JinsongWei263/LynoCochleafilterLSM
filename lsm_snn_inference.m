%% snn inference
clear ;
load lsmout.mat;
load net.mat;

set_size = size(label,2);

pre_label= size(label);
nn.rram_scale = 1e4;

%% linear classifer
lsmtrain = lsmout;

[lsmtrain, mu, sigma] = zscore(lsmtrain);
for i = 1 : size(lsmtrain,1)
    lsmtrain(i,:) = lsmtrain(i,:)/max(abs(lsmtrain(i,:)));
end
flowlabel = zeros(size(lsmout,1),10);
mn = size(lsmtrain,1);
li = size(lsmtrain,2);
ii = 0;
for l = 1 : mn
    for j = 1 : 10
        if j == label(l)+1
            flowlabel(l, j) = 1;
        end
    end
end
test_x = lsmtrain;
test_y = flowlabel;
[test_er, test_bad] = nntest(nn, test_x, test_y);
disp(['linear error is', num2str(test_er)]);
nn = nnff(nn, test_x, zeros(size(test_x,1), nn.size(end)));

%% snn classifer
for i = 1 : 10
    load(['spike',num2str(i),'mat.mat']);
    tic;
    [lsm, lsmspikes] = runLSM(lsm, spike);
    sumlsmspikes = sum(lsmspikes);
    lsmsame = sum(sumlsmspikes(1,:)==lsmout(i,:))==784;
    disp(['lsmsame is ', num2str(lsmsame)]);
    [snn,snnspikes] = runClassfier(nn, lsm, lsmspikes);
    sumspikes = sum(snnspikes);
    [dummy, prex] = max(sumspikes, [], 2);
    pre_label(i) = prex-1;
    
    disp(['case ', num2str(i), ', label ', num2str(label(i)), ', predict ', num2str(pre_label(i)), ...
        ' runtime ', num2str(toc*1000), 'ms']);
end
err = 1 - sum(pre_label==label) / size(label,2);
disp(["error is ", num2str(err)]);

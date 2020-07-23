%% BP Net
clear;
% load data/wavlsm.mat;
load data/wavdata.mat;

phase = ["filterlsm", "bp", "snnjson"];
% phase = ["bp", "snnjson"];

savespike = true;

%% Create Filter
opt.Fs = 8000;
opt.EarBreakFreq = 1000.0;
opt.EarQ = 8;
opt.EarStepFactor = 0.21;
opt.OriginalEarZeroOffset = 0.5;
opt.OriginalEarSharpness = 5.0;
opt.EarZeroOffset = 1.5;
opt.EarSharpness = 5.0;
opt.EarPremphCorner = 300.00;

[earfilter, cf] = CreateLynoCochleaFilter(opt);
%% create BSA filter
hearfilter = [0.0148264930711210,-0.0545957356107501,-0.00185072469746768,-0.0576891682999051,-0.0585522017011255,-0.0206252924614475,-0.138288795097396,0.0332863133250078,-0.207887220273215,0.0716629673876838,0.764556357556245,0.0716629673876838,-0.207887220273215,0.0332863133250078,-0.138288795097396,-0.0206252924614475,-0.0585522017011255,-0.0576891682999051,-0.00185072469746768,-0.0545957356107501,0.0148264930711210];
hearfilter = hearfilter - min(hearfilter);
hearfilter = hearfilter / max(abs(hearfilter)) * 0.29;
Hd = hfilter_design;
hfilter = Hd.Numerator;
hfilter = hfilter - min(hfilter);
hfilter = hfilter / max(abs(hfilter)) * 0.23;

%% create LSM
lsmopt.n = length(cf);
lsmopt.r = 1;
lsmopt.tm = 32;
lsmopt.tc = 64;
lsmopt.tf = 2;
lsmopt.dt = 1;
lsmopt.kz = 16;
lsmopt.kx = 4;
lsmopt.ky = 4;
lsmopt.vth = 20;
lsmopt.kee = 0.45;
lsmopt.kei = 0.3;
lsmopt.kie = 0.6;
lsmopt.kii = 0.15;
lsmopt.wee= 3;
lsmopt.wei= 6;
lsmopt.wie= -2;
lsmopt.wii= -2;
lsm = LSM(lsmopt);

%% start 
set_setp = 1;
% while (1)
for ph = 1 : length(phase)
    switch phase(ph)
        case "filterlsm"
%% filter 
            len = size(wav_len, 1);
            lsmout = zeros(len, lsm.m);
            label = wav_label;
            ii = 0;
            wavleft = 1;
            for twavindex = 1 : set_setp : len
                ii = ii + 1;
                wavindex = 1;
                disp(['number : ', num2str(wavindex), ' wave label : ', num2str(wav_label(wavindex))]);
                wav_test = wav_data(wavleft : wavleft+wav_len(wavindex)-1);
            	time = length(wav_test);
                wavleft = wavleft+wav_len(wavindex);
                
%                 display(['wave length :', num2str(time)]);
                %     label(i) = str2
            %% Applay Lynocochlea filter
%                 disp("Applay Lynocohlea Filter");
            	y = ApplyLynoCochleaFilter(wav_test', earfilter, opt);
            	channel = size(y, 1);
%                 disp(['Channel : ', num2str(channel)]);
                
            %% Applay BSA
%                 disp(["Applay BSA"]);
            	maxy = max(y');
            	for i = 1 : size(y, 1)
                	y(i, :) = y(i, :) ./ maxy(i);
            	end
            	multi = 31;
            	my = zeros(size(y,1), size(y,2)*multi);
            	for i = 1 : multi
                	my(:,i:multi:end) = y(:,:);
            	end
            	bsath = 0.75;
            	bsast = BSA(hfilter, my, bsath);
                spike = zeros(size(bsast, 1), size(bsast,2)/multi);
            	for i = 1 : multi
            	    spike(:,:) = max(spike(:,:), bsast(:,i:multi:end));
                end
                if (savespike)
                    spike_file_name = ['data/spike/spike', num2str(wavindex),'mat'];
                    spike_label = wav_label(wavindex);
                    save(spike_file_name, 'spike', 'spike_label');
                end
              %% Applay LSM
%                 disp(["Applay LSM"]);
                tic;
                [lsm, lsmspike] = runLSM(lsm, spike);
                disp(['wav ', num2str(wavindex), ' LSM running time ' , num2str(toc*1000), 'ms']);
%                 imshow(1-lsmspike');
                sumspike = sum(lsmspike);
                lsmout(wavindex,:) = sumspike(:);
            end
           %% 
            save('lsmout.mat', 'lsmout', 'label', 'lsm', 'earfilter');
        case "bp"
            %% 
            load lsmout.mat
            ti = int32(size(lsmout,2));
            lsmtrain = lsmout(:,1:end);
            t = diag(1./max(lsmtrain, [], 2));
            lsmtrain = t*lsmtrain;

            [lsmtrain, mu, sigma] = zscore(lsmtrain);

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
            
            kk = randperm(mn);
            train_m = round(mn*0.8);
            test_m  = mn - train_m;
            
            train_x = double(lsmtrain( kk(1 :set_setp: train_m), :));
%             train_y = zeros(size(train_x,1),10);
            train_y = flowlabel(kk(1:set_setp:train_m),:);
            test_x  = double(lsmtrain( kk(train_m+1 :set_setp: mn), :));
%             test_y  = zeros(size(test_x,1),10);
            test_y  = flowlabel(kk(train_m+1:set_setp:mn), :);
            
            mix_m = round(test_m*0.2);
            kk = randperm(test_m);
            sub_test_x = test_x(kk(1:mix_m),:);
            sub_test_y = test_y(kk(1:mix_m),:);
            kk = randperm(train_m);
            train_x(kk(1:mix_m),:) = sub_test_x(:,:);
            train_y(kk(1:mix_m),:) = sub_test_y(:,:);


            rand('state', 0);
            nn = nnsetup([li, 10]);
            opts.numepochs = 200;
            opts.batchsize = 20;
            [nn, L] = nntrain(nn, train_x, train_y, opts);
            [er, bad] = nntest(nn, train_x, train_y);
            [test_er, test_bad] = nntest(nn, test_x, test_y);
            if (er < 0.08)
                disp(['too small error : ', num2str(er*100),'%']);
                save('net.mat', 'lsm', 'earfilter');
            else
                disp(['enough big error : ', num2str(er*100),'%']);
            end

            disp(['test set error : ', num2str(test_er*100), '%']);

            fod = fopen('outspike.out', 'r');
            hw_case = zeros(lsm.m, 1);
            for i = 1 : lsm.m
                fscanf(fod, '%d', hw_case(i));
            end
            hw_case = normalized(hw_case', mu, sigma);
%             hw_case = hw_case' / max(hw_case);
            pre_label = nnpredict(nn, hw_case);
            disp(['case label ', num2str(4), ' pre_label ', num2str(pre_label)]);

        case "snnjson"
%             input layer
            lsm = lsm2json(lsm, 'data/lsm_net');
            for i = 1 : 2000                                           
                load(['spike',num2str(i),'mat.mat']);
                file = ['data/lsm_net/inspike',num2str(i),'in'];
                spike2ins(lsm,spike,i,spike_label,file);
            end
%             spike = spike2ins(lsm, spike);
        otherwise 
            disp(" underfied phase ");
    end
end
% end


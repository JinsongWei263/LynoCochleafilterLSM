%% Create Filter
opt.Fs = 8000;
opt.EarBreakFreq = 1000.0;
opt.EarQ = 8;
opt.EarStepFactor = 0.25;
opt.OriginalEarZeroOffset = 0.5;
opt.OriginalEarSharpness = 5.0;
opt.EarZeroOffset = 1.5;
opt.EarSharpness = 5.0;
opt.EarPremphCorner = 300.00;

[earfilter, cf] = CreateLynoCochleaFilter(opt);

%% create LSM
lsmopt.n = 64;
lsmopt.k = 0.45;
lsmopt.r = 1;
lsmopt.tm = 32;
lsmopt.tc = 64;
lsmopt.tf = 2;
lsmopt.dt = 1;
lsmopt.vth = 20;
lsmopt.kee = 0.45;
lsmopt.kei = 0.3;
lsmopt.kie = 0.6;
lsmopt.kii = 0.15;
lsmopt.wee= 3;
lsmopt.wei= 6;
lsmopt.wie= -2;
lsmopt.wii= -2;


% figure;
% plot(cf);
% figure;
[wav_test, fs] = audioread('./recordings/0_jackson_2.wav');
time = length(wav_test);
% plot(wav_test);
y = ApplyLynoCochleaFilter(wav_test', earfilter, opt);
channel = size(y, 1)
% y = y * 100


%%
maxy = max(y');
for i = 1 : size(y, 1)
    y(i, :) = y(i, :) ./ maxy(i);
end

yt=1;
if false
    figure ;
    for i = yt : yt
        plot(y(i,:));
        hold on;
    end
end
%%
multi = 11;
my = zeros(size(y,1), size(y,2)*multi);
for i = 1 : multi
    my(:,i:multi:end) = y(:,:);
end
%% BSA
hearfilter = [0.0148264930711210,-0.0545957356107501,-0.00185072469746768,-0.0576891682999051,-0.0585522017011255,-0.0206252924614475,-0.138288795097396,0.0332863133250078,-0.207887220273215,0.0716629673876838,0.764556357556245,0.0716629673876838,-0.207887220273215,0.0332863133250078,-0.138288795097396,-0.0206252924614475,-0.0585522017011255,-0.0576891682999051,-0.00185072469746768,-0.0545957356107501,0.0148264930711210];
hearfilter = hearfilter - min(hearfilter);
% hearfilter = max(hearfilter, 0);
hearfilter = hearfilter / max(abs(hearfilter)) * 0.29;


Hd = hfilter_design;
hfilter = Hd.Numerator;
hfilter = hfilter - min(hfilter);
hfilter = hfilter / max(abs(hfilter)) * 0.23;

bsath = 0.75;
bsast = BSA(hfilter, my, bsath);
% bsast = HSA(hearfilter, my);
bsay = [];
for i = 1 : size(bsast, 1)
    convt = conv(bsast(i,:), hfilter, 'full');
    bsay = [bsay; convt(1:time*multi)];
end

bsaerror = bsay - my;
Eacgy = sum(my.^2, 2);
Ebsaerror = sum(bsaerror.^2, 2);
BSASNDR = 20*log10(Eacgy./Ebsaerror);
% figure ;
% subplot(2, 2, 1);
% plot(BSASNDR);
% title("BSA SNDR");
% subplot(2,2,3);
% hold on;
% plot(my(1,:));
% plot(bsay(1,:));
% subplot(2,2,4);
% hold on;
% plot(my(channel,:));
% plot(bsay(channel,:));

% figure ;
% imshow((1-bsast(:,1500:3000))*255);
% spike = zeros(size(bsast, 1), size(bsast,2)/multi);
% for i = 1 : multi
%     spike(:,:) = max(spike(:,:), bsast(:,i:multi:end));
% end
% ml = 20;
% spikem = zeros(size(spike,1)*ml, size(spike,2));
% for i = 1 :5:  ml
%     spikem(i:ml:end,:) = spike(:,:);
% end
% imshow(1-spikem);
%%
yplot = false;
if ( yplot)
    figure ;
    subplot(4,6,1);
    for i=1 : 24
        plot(y(i,:));
        hold on;
        plot(bsay(i,:));
        subplot(4, 6, i);
        hold off;
    end
    figure;
    for i=25 : 48
        plot(y(i,:));
        plot(bsay(i,:));
        hold on;
        subplot(4, 6, i-24);
    end
    figure;
    for i=49 : 64
        plot(y(i,:));
        plot(bsay(i,:));
        hold on;
        subplot(3, 6, i-48);
    end
end

%% LSM
lsm = LSM(lsmopt);
[lsm, lsmspike] = runLSM(lsm, spike);
squarespike = reshape(lsmspike, [4,8]);
figure;
imshow(1-squarespike);
plot(lsmspike);
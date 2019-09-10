clear;

opt.Fs = 8000;
opt.EarBreakFreq = 1000.0;
opt.EarQ = 8;
opt.EarStepFactor = 0.25;
opt.OriginalEarZeroOffset = 0.5;
opt.OriginalEarSharpness = 5.0;
%%
figure;
cf = [1 : 1 : opt.Fs/2];
bandwidth = EarBandwidth(cf, opt);
subplot(3, 4, 1);
plot(cf, bandwidth);
title('bandwidth');

zerocf = OriginalZeroCF(cf, opt);
subplot(3, 4, 2);
plot(cf, zerocf);
title('zeroCF');

zeroq = OriginalZeroQ(cf, opt);
subplot(3, 4, 3);
plot(cf, zeroq);
title('zeroQ');

polecf = OriginalPoleCF(cf, opt);
subplot(3, 4, 4);
plot(cf, polecf);
title('polecf');

poleq = OriginalPoleQ(cf, opt);
subplot(3, 4, 5);
plot(cf, poleq);
title('poleq');

index = 1;
cf = [];
while(true)
    realcf = OriginalEarChannelCF(index,opt);
    index = index + 1;
    if (realcf < 63)
        break; 
    end
    cf = [cf, realcf];
end
subplot(3, 4, 6);
plot(cf);
title('realcf');
%% cascadecf
cf = [];
index = 1;
opt.EarZeroOffset = 1.5;
opt.EarSharpness = 5.0;

while(true)
    cascadecf = EarChannelCF(index, opt);
    index = index + 1;
    if (cascadecf < 63)
        break;
    end
    cf = [cf, cascadecf];
end
subplot(3, 4, 7);
plot(cf);
title('cascadeCF');

cascadezerocf = CascadeZeroCF(cf, opt);
subplot(3, 4, 8);
plot(cf, cascadezerocf);
title('CascadeZeroCF');
cascadezeroq = CascadeZeroQ(cf, opt);
subplot(3, 4, 9);
plot(cf, cascadezeroq);
title('CascadeZeroQ');
cascadepolecf = CascadePoleCF(cf, opt);
subplot(3, 4, 10);
plot(cf, cascadepolecf);
title('CascadePolecf');
cascadepoleq = CascadePoleQ(cf, opt);
subplot(3, 4, 11);
plot(cf, cascadepoleq);
title('CasacdePoleQ');
%% Create Cochlea Filter Bank

%% Outer, Middle Ear Filter and Ear Front Filter
opt.EarPremphCorner = 300.00;

unitfilter.B = [1];
unitfilter.A = [1];
unitfilter.G = 1;

pf = FirstOrderFromCorner(opt.EarPremphCorner, opt.Fs);
outermiddleearfillter = MakeFilter(FirstOrderFromCorner(opt.EarPremphCorner, opt.Fs), ...
                        unitfilter, 0, opt.Fs, 1.0);

tfilter.B = [1,0,-1];
tfilter.A = [1];
tfilter.G = 1;
compenstator = MakeFilter(tfilter, unitfilter, opt.Fs/4, opt.Fs, 1);
earfrontfilter = CascadeFilter(outermiddleearfillter, compenstator);

prefirststagefilter = SecondOrderFromCenterQ( cascadepolecf(1), cascadepoleq(1), opt.Fs);
earfrontfilter = CascadeFilter(earfrontfilter,  MakeFilter(unitfilter, prefirststagefilter, ...
                                                        opt.Fs/4, opt.Fs, 1.0));
%% Ear Stage Filter

earfilter = [earfrontfilter];
dcgain = cf(1:end-1) ./ cf(2:end);
for i = 2 : length(cascadezerocf)
    earstagefilter = MakeFilter( SecondOrderFromCenterQ(cascadezerocf(i), cascadezeroq(i), opt.Fs), ...
                                 SecondOrderFromCenterQ(cascadepolecf(i), cascadepoleq(i), opt.Fs), ...
                                 0.0, opt.Fs, ...
                                 dcgain(i-1));

    earfilter = [earfilter, earstagefilter];
end
figure ;

f = [1:opt.Fs/2];
freqstage = ones(size(f));
freq = [];
for i = 1 : size(earfilter,2)
    freqstage = freqstage .* FilterEval(earfilter(i), f, opt.Fs) .* earfilter(i).G;
    freq = [freq; freqstage];
end
size(freq)
% plot(20*log10(abs(freq)));
subplot(2,3,1);
plot(f, 20*log10(abs(freq(2, :))));
subplot(2,3,2);
plot(f, 20*log10(abs(freq(5, :))));
subplot(2,3,3);
plot(f, 20*log10(abs(freq(10, :))));
subplot(2,3,4);
plot(f, 20*log10(abs(freq(30, :))));
subplot(2,3,5);
plot(f, 20*log10(abs(freq(50, :))));
subplot(2,3,6);
plot(f, 20*log10(abs(freq(64, :))));

%% Apply Filter
channel = length(cf)

[wav_test, fffs] = audioread('./recordings/0_jackson_0.wav');
time = length(wav_test);

x = wav_test;
y = zeros(channel, time);

figure ;
plot(x);

for i = 1 : channel
    x = filter(earfilter(i).B(end:-1:1), earfilter(i).A(end:-1:1), x) * abs(earfilter(i).G);
    y(i, :) = x;
end
%% Half Wave Rectification (HWR)
hwrx = zeros(channel, time);
acgx = zeros(channel, time);


% hwrx = abs(y).*(abs(angle(y))<=pi/2);
hwrx = abs(y).*(angle(y)>=0);
% hwrx = abs(y);
acgx = hwrx;
figure;
for i = 1 : 20
    subplot(4, 6, i);
    Ay = abs(fft(y(i*3,:)));
    Ay = Ay(1:length(Ay)/2);
    plot((0:pi/(length(Ay)-1):pi),Ay);
end


%% Automatic Gain Control (AGC)

target = 1.0;
epsilon = 0.2;

targetstage=[0.0032, 0.0016, 0.0008, 0.0004];

state = zeros(channel, time);
acgy = zeros(channel, time);

for acgstage = 1 : 4
    target = targetstage(acgstage);
    state = zeros(channel, time);
    acgy = zeros(channel, time);
    for i = 1 : channel
        for t = 1 : time
            if t == 1
                state(i, t) = 0;
                acgy(i, t) =  (1 - state(i, t))./(1+state(i,t)) .* acgx(i, t);
            else 
                if (i==1)
                    state(i, t) = (state(i+1,t-1) + state(i, t-1)) * (1-epsilon)/3;
                elseif (i==channel)
                    state(i, t) = (state(i-1,t-1) + state(i, t-1)) * (1-epsilon)/3;
                else 
                    state(i, t) = (state(i-1,t-1) + state(i+1,t-1) + state(i, t-1)) * (1-epsilon)/3;
                end
                state(i, t) = state(i, t) + acgy(i, t-1) * epsilon/target;
%               state(i, t) = acgy(i, t) * epsilon / target + state(i, t) * (1-epsilon);
                acgy(i, t) =  (1 - state(i, t))./(1+state(i,t)) .* acgx(i, t);
            end
        end
    end
    acgx = acgy;
end

%% test BSA
x = [1 5 13 15 7 7 6 2 9 5 -2; 2 5 13 15 7 7 6 2 9 5 -2];
BSAfilter = [1 4 9 5 -2];
threshold = 0.9550;
bsa = BSA(BSAfilter, x, threshold);
hsa = HSA(BSAfilter, x);
tbsay = [];
thsay = [];
for i = 1 : size(bsa, 1)
    tbsay = [tbsay; conv(bsa(i,:), BSAfilter, 'full')];
    thsay = [thsay; conv(hsa(i,:), BSAfilter, 'full')];
end

%% true BSA
mfilter = [8, 16, 26, 35, 44, 52, 59, 64, 65, 64, 61, 57, 52, 45, 37, 29, 21, 13, 7, 4];
bsath = 0.955;

hearfilter = [0.0148264930711210,-0.0545957356107501,-0.00185072469746768,-0.0576891682999051,-0.0585522017011255,-0.0206252924614475,-0.138288795097396,0.0332863133250078,-0.207887220273215,0.0716629673876838,0.764556357556245,0.0716629673876838,-0.207887220273215,0.0332863133250078,-0.138288795097396,-0.0206252924614475,-0.0585522017011255,-0.0576891682999051,-0.00185072469746768,-0.0545957356107501,0.0148264930711210];
hearfilter = hearfilter - min(hearfilter);
hearfilter = hearfilter / max(abs(hearfilter)) *  0.3;
minacgy = min(acgy');
for i = 1 : size(acgy,1)
    acgy(i,:) = acgy(i,:) - minacgy(i);
end

maxacgy = max(acgy');
for i = 1 : size(acgy, 1)
    acgy(i,:) = acgy(i,:) ./ maxacgy(i);
end

hsast = HSA(hearfilter, acgy);
bsast = BSA(hearfilter, acgy, bsath);

bsay = [];
hsay = [];
for i = 1 : size(bsast, 1)
    convt = conv(bsast(i,:), hearfilter, 'full');
    bsay = [bsay; convt(1:time)];
    convt = conv(hsast(i,:), hearfilter, 'full');
    hsay = [hsay; convt(1:time)];
end
figure;
plot(bsay(55,:));
hold on;
plot(acgy(55,:));

bsaerror = bsay-acgy;
hsaerror = hsay-acgy;

Eacgy = sum(acgy.^2, 2);
Ebsaerror = sum(bsaerror.^2, 2);
Ehsaerror = sum(hsaerror.^2, 2);
BSASNDR = 10*log10(Eacgy./Ebsaerror);
HSASNDR = 10*log10(Eacgy./Ehsaerror);
figure ;
subplot(1,2,1);
plot(BSASNDR);
title("BSA SNDR");
subplot(1,2,2);
plot(HSASNDR);
title("HSA SNDR");

%% get sound data
% sound_data = wav_read();

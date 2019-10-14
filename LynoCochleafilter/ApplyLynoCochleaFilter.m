function acgy = ApplyLynoCochleaFilter(x, earfilter, opt)


fs = opt.Fs;

%% Apply Filter
channel = size(earfilter,2);
time = size(x, 2);
y = zeros(channel, time);

for i = 1 : channel
    x = filter(earfilter(i).B(end:-1:1), earfilter(i).A(end:-1:1), x) * abs(earfilter(i).G);
    y(i, :) = x;
end

%% Half Wave Rectification (HWR)
hwrx = zeros(channel, time);
acgx = zeros(channel, time);

hwrx = abs(y).*(real(y)>=0);
acgx = hwrx;

if false
    figure ;
    for i = 1 : channel
        plot(acgx(i,:));
        hold on;
    end
end
%% Automatic Gain Control (AGC)
target = 1.0;

epsilon = zeros(1,4);
epsilon(1) = 1 - exp(-1/0.64/fs);
epsilon(2) = 1 - exp(-1/0.16/fs);
epsilon(3) = 1 - exp(-1/0.04/fs);
epsilon(4) = 1 - exp(-1/0.01/fs);

targetstage=[0.0032, 0.0016, 0.0008, 0.0004];
acgy = zeros(channel, time);

statelimit = 0.9;

for acgstage = 1 : 4
    target = targetstage(acgstage);
    eps = epsilon(acgstage)/target;
    eps1 = (1 - epsilon(acgstage))/3.0;
    state = ones(channel,1) * statelimit;

    for t = 1 : time
        acgy(:,t)  = acgx(:,t) .* (1 - state);
        state(1) = acgy(1,t) * eps + eps1*(state(1) + state(1) + state(2));
        state(2:end-1) = acgy(2:end-1,t) * eps + eps1 * (state(1:end-2) + state(2:end-1) + state(3:end));
        state(end) = acgy(end, t)*eps + eps1*(state(end-1) + state(end) + state(end));
        state(state>statelimit) = statelimit;
    end
    
    acgx = acgy;
end

% for acgstage = 1 : 4
%     target = targetstage(acgstage);
%     eps = epsilon(acgstage)/target;
%     eps1 = (1 - epsilon(acgstage))/3.0;
%     state = ones(1,channel) * statelimit;
%     for t = 1 : time
%         for i = 1 : channel
%             acgy(i, t) = acgx(i, t) * ( 1 - state(i));
%             if (acgy(i, t) < 0) 
%                 acgy(i, t) = 0;
%             end
%             if ( i==1) 
%                 state(i) = acgy(i, t) * eps + eps1*(state(i) + state(i) + state(i+1));
%             elseif (i == channel) 
%                 state(i) = acgy(i, t) * eps + eps1*(state(i-1) + state(i-1) + state(i));
%             else
%                 state(i) = acgy(i, t) * eps + eps1*(state(i-1) + state(i) + state(i+1));
%             end
%             if (state(i)>statelimit) 
%                 state(i) = statelimit;
%             end
%         end
%     end
%     acgx = acgy;
% end

end
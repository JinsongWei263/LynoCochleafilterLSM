function sound_data = wav_read()
    filename = './recordings/wav_list.txt';
    sound_data = [];
    wav_list = textread(filename, '%s');
    len = size(wav_list, 1);
    maxlen=0;
    minlen = 18262;
    for i = 1 : len
        wav_name = char(strcat('./recordings/', wav_list(i)));
        [wav, fs] = audioread(wav_name);
        maxlen = max(maxlen, size(wav, 1));
        minlen = min(minlen, size(wav, 1));
%         sound_data = [sound_data ; wav'];
    end
    for i = 1 : len
        wav_name = char(strcat('./recordings/', wav_list(i)));
        [wav, fs] = audioread(wav_name);
        wav = wav';
        if length(wav) < maxlen
            wav = [wav, zeros(1, maxlen-length(wav))];
        end
        sound_data = [sound_data ; wav];
    end
end

% clear ;
% [wav_test, fs] = audioread('./recordings/0_jackson_0.wav');
% plot(wav_test);

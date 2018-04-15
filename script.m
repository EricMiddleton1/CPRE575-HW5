%% Part 3 - Spectrograms
%Load files
[audio_life, fs_life] = audioread('input/Part_3/generated/01-extralife.wav');
[audio_siren, fs_siren] = audioread('input/Part_3/generated/02-siren1.wav');
[audio_fruit, fs_fruit] = audioread('input/Part_3/generated/03-fruiteaten.wav');
[audio_ghost, fs_ghost] = audioread('input/Part_3/generated/04-ghosteaten.wav');
[audio_death, fs_death] = audioread('input/Part_3/generated/05-pacmandeath.wav');

%Generate spectrograms
figure; spectrogram(audio_life); title('Spectrogram - Extra Life');
figure; spectrogram(audio_siren); title('Spectrogram - Siren 1');
figure; spectrogram(audio_fruit); title('Spectrogram - Fruit Eaten');
figure; spectrogram(audio_ghost); title('Spectrogram - Ghost Eaten');
figure; spectrogram(audio_death); title('Spectrogram - Pacman Death');

%% Part 4 - Sirens
%Load original files
[audio_siren1, fs_siren1] = audioread('input/Part_4/original/mono/siren1.wav');
[audio_siren2, fs_siren2] = audioread('input/Part_4/original/mono/siren2.wav');
[audio_siren3, fs_siren3] = audioread('input/Part_4/original/mono/siren3.wav');
[audio_siren4, fs_siren4] = audioread('input/Part_4/original/mono/siren4.wav');
[audio_siren5, fs_siren5] = audioread('input/Part_4/original/mono/siren5.wav');

%Generate spectrograms
nsc = 1024;
nov = floor(nsc/2);
nff = max(256, 2^nextpow2(nsc));

spectrogram(audio_siren5, hamming(nsc), nov, nff, fs_siren5, 'yaxis');

%% Part 4 - Generate siren sound
%f0, f1, period extracted from spectrograms
gen_siren2 = generate_siren(375, 1172, 0.768-0.4053, fs_siren2, 6);
gen_siren3 = generate_siren(421.9, 1359, 0.704-0.3627, fs_siren3, 6);
gen_siren4 = generate_siren(562.5, 1549, 0.6507-0.3413, fs_siren4, 6);
gen_siren5 = generate_siren(656.2, 1688, 0.5867-0.2987, fs_siren5, 6);

%% Part 5 - Extra Life
%Load original file
[audio_life, fs_life] = audioread('input/Part_5/original/mono/extralife.wav');

%Generate spectrograms
nsc = 1024;
nov = floor(nsc/2);
nff = max(256, 2^nextpow2(nsc));

figure;
spectrogram(audio_life, hamming(nsc), nov, nff, fs_life, 'yaxis');

%% Part 5 - Generate sound
ding_dur = 0.2;
ding_count = 10;
decay = 0.26;
ding = {};
ding{1} = generate_ding(375, decay, fs_life, ding_dur)*0.75;
ding{2} = generate_ding(750, decay, fs_life, ding_dur)*0.1;
ding{3} = generate_ding(1500, decay, fs_life, ding_dur)*1;
ding{4} = generate_ding(3000, decay, fs_life, ding_dur)*0.5;
ding{5} = generate_ding(9000, decay, fs_life, ding_dur)*0.25;
ding{6} = generate_ding(15000, decay, fs_life, ding_dur)*0.1;

single_ding = [];

%Pad lengths with 0 to match and sum
len = 0;
for i = 1:length(ding)
    len = max(len, length(ding{i}));
end
for i = 1:length(ding)
    ding{i} = [ding{i} zeros(1, len - length(ding{i}))];
    if length(single_ding) == 0
        single_ding = ding{i};
    else
        single_ding = single_ding + ding{i};
    end
end
single_ding = single_ding / length(ding);

full_ding = [];
for i = 1:ding_count
    full_ding = [full_ding single_ding];
end
sound(full_ding, fs_life);
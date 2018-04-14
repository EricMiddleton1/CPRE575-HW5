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

spectrogram(audio_life, hamming(nsc), nov, nff, fs_life, 'yaxis');
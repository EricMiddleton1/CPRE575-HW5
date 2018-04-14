%initialize the sound samples array
soundarr=[];

%set the sample rate
fs = 44100;

%length of a single segment
time=0.01875;

% Create time interval from 0 to time
t = 0 : 1/fs : time;

% base frequency values
lowf = 600;
lowscale = 115;

triangle = 0 : 1/fs : time;

% generate the triangle wave function
% for N=1:4
%     
%     triangle = triangle + wave;
% end

% generate 5 periods of the siren
for v = 1:5 
    %generate the up
    for stair = 0:10
        triangle = (2*lowf*(t-(1/lowf).*floor(t.*lowf + 1/2)).*(-1).^(floor(t*lowf + 1/2)));
        lowf = lowf + lowscale;
        
        %add this segment to the sound
        soundarr = [soundarr, triangle];
    end
    
    %generate the down
    for stair = 0:10
        triangle = (2*lowf*(t-(1/lowf).*floor(t.*lowf + 1/2)).*(-1).^(floor(t*lowf + 1/2)));

        lowf = lowf - lowscale;
        
        soundarr = [soundarr, triangle];
    end
end

%display the spectrogram
figure; spectrogram(soundarr,512,256,512,fs, 'yaxis');

%play the sound
%sound(soundarr,fs);

%save the sound to file
audiowrite('siren1.wav', soundarr, fs);
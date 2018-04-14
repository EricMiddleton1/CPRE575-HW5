%Function to generate triangle wave siren
function y = generate_siren(f0, f1, period, fs, duration)
    y = [];
    
    while length(y) < (fs*duration)
        %Calculate current frequency
        curTime = length(y) / fs;
        phase = mod(curTime, period) / (period/2);
        if phase < 1
            f = phase * (f1-f0) + f0;
        else
            f = (2 - phase) * (f1-f0) + f0;
        end
        
        %Generate single triangle wave
        y = [y -1:4/(fs/f):1 1:-4/(fs/f):-1];
    end
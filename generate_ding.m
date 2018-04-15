%Function to generate decaying triangle wave
function y = generate_ding(f, decay, fs, duration)
    y = [];
    
    while length(y) < (fs*duration)
        %Calculate current amplitude
        a = 1-length(y)/(decay*fs);
        
        %Generate single triangle wave
        triangle = [-1:4/(fs/f):1 1:-4/(fs/f):-1];
        y = [y a*triangle];
    end
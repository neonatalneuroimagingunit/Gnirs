function [s, tline] = gen_synth_nirs(nsamples, nchannels, fs, plot_output)

% Create a synthetic fNIRS signal as from Scholkmann et al. 2010

% Written by Matteo Caffini, Rovereto 06/07/2018

x = 1:1:nsamples;
tline = x / fs;

f = [1 0.25 0.1 0.04];
w = [0.6 0.2 0.9 1];
g = 100*[0.01 0.01 0.01 0.05];

morenoise = 5;

nfrequencies = length(f);
s = zeros(nsamples, nchannels);

temp = zeros(nsamples, nfrequencies);

if plot_output
    figure
    p1 = subplot(1,2,1);
    hold(p1, 'on');
    p2 = subplot(1,2,2);
    hold(p2, 'on');
end

for cc = 1:1:nchannels
    for ff = 1:1:nfrequencies
        %temp(:,ff) = w(ff)*sin(2*pi*f(ff)*tline);
        temp(:,ff) = w(ff)*sin(2*pi*f(ff)*tline) + g(ff)*randn(1,nsamples);
        %temp(:,ff) = awgn(temp(:,ff), g(ff));
    end
    
    temp = sum(temp,2);
    
    temp = awgn(temp, morenoise);
    
    s(:,cc) = temp;
    
    spectrum = fft(temp);
    n = length(tline);                % number of samples
    fline = (0:n-1)*(fs/n);           % frequency range
    power = abs(spectrum).^2/n;   % power of the DFT
 
    if plot_output
        plot(p1, tline, temp)
        plot(p2, fline, power)
    end
end
end
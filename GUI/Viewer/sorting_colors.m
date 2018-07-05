function channelColors = sorting_colors(nchannels, sortingmethod)
%
% Colors to sort lines in main plot
% Available sorting methods:
%        - type
%        - location
%        - channel
%        - wavelength

% Written by Matteo Caffini
% CIMeC - Universita' dgli Studi di Trento
% on June, 29th 2018 in Rovereto (TN)
%

switch sortingmethod
    case 'wavelength'
        spam = lines(2);
        channelColors = zeros(nchannels, 3);
        channelColors(1:2:end,:) = repmat(spam(1,:),[nchannels/2 1]);
        channelColors(2:2:end,:) = repmat(spam(2,:),[nchannels/2 1]);
    case 'channel'
        spam = lines(nchannels/2);
        channelColors = repmat(spam,[nchannels/2 1]);
    case 'sortnomo'
        channelColors = lines(nchannels);
    case 'type' % not sure it's necessary (intended to sort by AC, DC, Ph)
        channelColors = lines(nchannels);
end
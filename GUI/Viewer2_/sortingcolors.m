function channelColors = sortingcolors(nchannels, sortingmethod)
%
% Colors to sort lines in main plot
% Available sorting methods:
%        - type
%        - location
%        - channel
%        - wavelength

% Written by Matteo Caffini Modify by Nadir
% CIMeC - Universita' dgli Studi di Trento
% on June, 29th 2018 in Rovereto (TN)
%
switch sortingmethod
    case 'wavelength'
        spam = lines(2);
        channelColors =  repmat(spam,nchannels/2,1);
    case 'channel'
        spam = lines(nchannels/2);
        channelColors(1:2:nchannels,:) = spam;
        channelColors(2:2:nchannels,:) = spam;
    case 'sortnomo'
        channelColors = lines(nchannels);
end

end

function change_line_width(hObject, eventData, channelColors, linewidthCurrent, linewidthFactor, hplot, hmetadata, fs)

% Change LineWidth in raw_explorer main plot
%
% Written by Matteo Caffini
% CIMeC - Universita' dgli Studi di Trento
% on July, 14th 2017 in Rovereto (TN)
%

cla(hplot.spectrumaxes);
all_lines = findall(gca,'Type','line');
n_lines = length(all_lines);
nchannels = size(channelColors, 1);
colorBackground = [200 200 200]/255;
colorForeground = flipud(channelColors);
alphaBackground = 0.3;
alphaForeground = 1;

start = int32(hplot.bigaxes2.XLim(1));
stop = int32(hplot.bigaxes2.XLim(2));

if start < 1
    start = 1;
end
if stop > str2double(hmetadata(1).value(3).String)
    stop = int32(str2double(hmetadata(1).value(3).String));
end

xdataavg = all_lines.XData;
xdataavg = xdataavg(start:stop);
ydataavg = mean(eventData.Source.YData(start:stop)) * ones([1 length(xdataavg)]);

xdata = all_lines.XData;
xdata = xdata(start:stop);
ydata = eventData.Source.YData(start:stop); % sample frequency (Hz)
%t = 0:1/fs:10-1/fs;                      % 10 second span time vector
spectrum = fft(ydata);
n = length(xdata);          % number of samples
f = (0:n-1)*(fs/n);     % frequency range
power = abs(spectrum).^2/n;    % power of the DFT
power = smooth(power, 500);
power = power/max(power);

linewidthForeground = linewidthFactor*linewidthCurrent;
linewidthBackground = linewidthCurrent;

if get(hObject, 'Type') == 'line'
    if get(hObject, 'Color') == colorBackground
        for ii = 1:1:n_lines
            set(all_lines(ii), 'Color', colorForeground(ii,:));
        end
        if get(hObject, 'LineWidth') == linewidthBackground
            colorSelected = get(hObject, 'Color');
            set(all_lines, 'LineWidth', linewidthBackground)
            set(all_lines, 'Color', [colorBackground alphaBackground])
            set(hObject, 'LineWidth', linewidthForeground)
            set(hObject, 'Color', [colorSelected alphaForeground])
            hmetadata(4).value(3).String = hObject.DisplayName;
            hmetadata(4).value(2).String = [num2str(round(10*mean(eventData.Source.YData))/10) ' ' char(177) ' ' num2str(round(10*std(eventData.Source.YData))/10)];
            hmetadata(4).value(1).String = [num2str(round(10*mean(eventData.Source.YData(start:stop)))/10) ' ' char(177) ' ' num2str(round(10*std(eventData.Source.YData(start:stop)))/10)];
            
            %hplot.avg1 = plot(xdataavg, ydataavg, 'Color', [1 0 0], 'LineWidth', 6);
            spectrumline = plot(f,  power, 'Parent', hplot.spectrumaxes, 'Color', colorSelected, 'LineWidth', 2);
            hplot.spectrumaxes.XLim = [0 2];
            hplot.spectrumaxes.YLim = [0 0.1];
            hplot.spectrumaxes.Color = [1 1 1 0];
            hplot.spectrumaxes.Box = 'off';
            hplot.spectrumaxes.Visible = 'on';
        else
            set(all_lines, 'LineWidth', linewidthBackground)
            for ii = 1:1:n_lines
                set(all_lines(ii), 'Color', [colorForeground(ii,:) 1]);
            end
            hmetadata(4).value(3).String = '-';
            hmetadata(4).value(2).String = '-';
            hmetadata(4).value(1).String = '-';
            hplot.spectrumaxes.Visible = 'off';
        end
    else
        if get(hObject, 'LineWidth') == linewidthBackground
            colorSelected = get(hObject, 'Color');
            set(all_lines, 'LineWidth', linewidthBackground)
            set(all_lines, 'Color', [colorBackground alphaBackground])
            set(hObject, 'LineWidth', linewidthForeground)
            set(hObject, 'Color', [colorSelected alphaForeground])
            hmetadata(4).value(3).String = hObject.DisplayName;
            hmetadata(4).value(2).String = [num2str(round(10*mean(eventData.Source.YData))/10) ' ' char(177) ' ' num2str(round(10*std(eventData.Source.YData))/10)];
            hmetadata(4).value(1).String = [num2str(round(10*mean(eventData.Source.YData(start:stop)))/10) ' ' char(177) ' ' num2str(round(10*std(eventData.Source.YData(start:stop)))/10)];
            plot(f,  power, 'Parent', hplot.spectrumaxes, 'Color', colorSelected, 'LineWidth', 2);
            hplot.spectrumaxes.XLim = [0 2];
            hplot.spectrumaxes.YLim = [0 0.1];
            hplot.spectrumaxes.Color = [1 1 1 0];
            hplot.spectrumaxes.Box = 'off';
            hplot.spectrumaxes.Visible = 'on';
        else
            set(all_lines, 'LineWidth', linewidthBackground)
            for ii = 1:1:n_lines
                set(all_lines(ii), 'Color', [colorForeground(ii,:) 1]);
            end
            hmetadata(4).value(3).String = '-';
            hmetadata(4).value(2).String = '-';
            hmetadata(4).value(1).String = '-';
            hplot.spectrumaxes.Visible = 'off';
        end
    end
end
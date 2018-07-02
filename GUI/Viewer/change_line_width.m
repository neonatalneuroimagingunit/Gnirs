function change_line_width(hObject, eventData, channelColors, linewidthCurrent, linewidthFactor, hplot, hmetadata)

% Change LineWidth in raw_explorer main plot
%
% Written by Matteo Caffini
% CIMeC - Universita' dgli Studi di Trento
% on July, 14th 2017 in Rovereto (TN)
%

all_lines = findall(gca,'Type','line');
colorBackground = [200 200 200]/255;
colorForeground = flipud(channelColors);
alphaBackground = 0.4;
alphaForeground = 1;

n_lines = length(all_lines);

start = hplot.bigaxes2.XLim(1);
stop = hplot.bigaxes2.XLim(2);

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
            hmetadata(4).value(3).String = num2str(1);
            hmetadata(4).value(2).String = [num2str(round(10*mean(eventData.Source.YData))/10) ' ' char(177) ' ' num2str(round(10*std(eventData.Source.YData))/10)];
            hmetadata(4).value(1).String = [num2str(round(10*mean(eventData.Source.YData(start:stop)))/10) ' ' char(177) ' ' num2str(round(10*std(eventData.Source.YData(start:stop)))/10)];
            %plot(mean(eventData.Source.YData(start:stop)))
        else
            set(all_lines, 'LineWidth', linewidthBackground)
            for ii = 1:1:n_lines
                set(all_lines(ii), 'Color', [colorForeground(ii,:) 1]);
            end
            hmetadata(4).value(1).String = num2str(2);
        end
    else
        if get(hObject, 'LineWidth') == linewidthBackground
            colorSelected = get(hObject, 'Color');
            set(all_lines, 'LineWidth', linewidthBackground)
            set(all_lines, 'Color', [colorBackground alphaBackground])
            set(hObject, 'LineWidth', linewidthForeground)
            set(hObject, 'Color', [colorSelected alphaForeground])
            hmetadata(4).value(1).String = num2str(3);
        else
            set(all_lines, 'LineWidth', linewidthBackground)
            for ii = 1:1:n_lines
                set(all_lines(ii), 'Color', [colorForeground(ii,:) 1]);
            end
            hmetadata(4).value(1).String = num2str(4);
        end
    end
end
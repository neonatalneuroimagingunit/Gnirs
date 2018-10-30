function change_width(~,evnt,GHandle, vIdx)

colorBackground = [200 200 200]/255;
alphaBackground = 0.3;
alphaForeground = 1;
lineWidth = 0.5;
linewidthFactor = 2;

edvLine = evnt.AffectedObject.edvLine;
if all(edvLine)
    linewidthBackground = lineWidth;
    linewidthForeground = lineWidth;
else
    linewidthForeground = lineWidth*linewidthFactor;
    linewidthBackground = lineWidth/linewidthFactor;
end

color = GHandle.Viewer(vIdx).WatchList.colorLine;

for lineIdx = 1 : length(edvLine)
    if (edvLine(lineIdx))
        GHandle.Viewer(vIdx).timeplot.lines1(:,lineIdx).Color = [color(lineIdx,:), alphaForeground];
        GHandle.Viewer(vIdx).timeplot.lines1(:,lineIdx,:).LineWidth = lineWidth;
        
        GHandle.Viewer(vIdx).spectrumplot.lines1(:,lineIdx).Color = [color(lineIdx,:), alphaForeground];
        GHandle.Viewer(vIdx).spectrumplot.lines1(:,lineIdx,:).LineWidth = lineWidth;
    else
        GHandle.Viewer(vIdx).timeplot.lines1(:,lineIdx).Color = [colorBackground, alphaBackground];
        GHandle.Viewer(vIdx).timeplot.lines1(:,lineIdx).LineWidth = linewidthBackground;
        
        GHandle.Viewer(vIdx).spectrumplot.lines1(:,lineIdx).Color = [colorBackground, alphaBackground];
        GHandle.Viewer(vIdx).spectrumplot.lines1(:,lineIdx).LineWidth = linewidthBackground;
    end
end
if sum(edvLine) == 1
    GHandle.Viewer(vIdx).timefrequencyplot.bigaxes.Visible = 'on';
    cla(GHandle.Viewer(vIdx).timefrequencyplot.bigaxes);
    GHandle.Viewer(vIdx).timefrequencyplot.text.Visible = 'off';
    GHandle.Viewer(vIdx).WatchList.timefreq2Plot = edvLine;
    
    GHandle.Viewer(vIdx).timeplot.lines1(edvLine).LineWidth = linewidthForeground;
    uistack(GHandle.Viewer(vIdx).timeplot.lines1(edvLine),'top');
    
    GHandle.Viewer(vIdx).spectrumplot.lines1(edvLine).LineWidth = linewidthForeground;
    uistack(GHandle.Viewer(vIdx).spectrumplot.lines1(edvLine),'top');
    
else
    GHandle.Viewer(vIdx).timefrequencyplot.bigaxes.Visible = 'off';
    cla(GHandle.Viewer(vIdx).timefrequencyplot.bigaxes);
    GHandle.Viewer(vIdx).timefrequencyplot.text.Visible = 'on';
end


end


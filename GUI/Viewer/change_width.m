function change_width(~,evnt,GHandle, vIdx)

colorBackground = [200 200 200]/255;
alphaBackground = 0.3;
alphaForeground = 1;
lineWidth = 2;
linewidthFactor = 2;

linewidthForeground = lineWidth*linewidthFactor;
linewidthBackground = lineWidth/linewidthFactor;

edvLine = evnt.AffectedObject.edvLine;
color = GHandle.Viewer(vIdx).WatchList.colorLine;

for lineIdx = 1 : length(edvLine)
	if (edvLine(lineIdx))
		GHandle.Viewer(vIdx).timeplot.lines1(:,lineIdx).Color = [color(lineIdx,:), alphaForeground];
		GHandle.Viewer(vIdx).timeplot.lines1(:,lineIdx,:).LineWidth = lineWidth;
	else
		GHandle.Viewer(vIdx).timeplot.lines1(:,lineIdx).Color = [colorBackground, alphaBackground];
		GHandle.Viewer(vIdx).timeplot.lines1(:,lineIdx).LineWidth = linewidthBackground;
	end
end
if sum(edvLine) == 1
    GHandle.Viewer(vIdx).timeplot.lines1(edvLine).LineWidth = linewidthForeground;
    uistack(GHandle.Viewer(vIdx).timeplot.lines1(edvLine),'top');
end


end


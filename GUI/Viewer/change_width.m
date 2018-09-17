function change_width(~,evnt,GHandle)

colorBackground = [200 200 200]/255;
alphaBackground = 0.3;
alphaForeground = 1;
lineWidth = 2;
linewidthFactor = 2;

linewidthForeground = linewidthFactor*lineWidth;
linewidthBackground = lineWidth;

edvLine = evnt.AffectedObject.edvLine;
color = GHandle.Viewer.WatchList.colorLine;

for lineIdx = 1 : length(edvLine)
	if (edvLine(lineIdx))
		GHandle.Viewer.timeplot.lines1(:,lineIdx).Color = [color(lineIdx,:), alphaForeground];
		GHandle.Viewer.timeplot.lines1(:,lineIdx,:).LineWidth = linewidthForeground;
	else
		GHandle.Viewer.timeplot.lines1(:,lineIdx).Color = [colorBackground, alphaBackground];
		GHandle.Viewer.timeplot.lines1(:,lineIdx).LineWidth = linewidthBackground;
	end
end
if sum(edvLine) == 1
	uistack(GHandle.Viewer.timeplot.lines1(edvLine),'top');
end


end


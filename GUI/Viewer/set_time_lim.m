function set_time_lim(~,evnt,GHandle, vIdx)


fs = GHandle.CurrentDataSet.Measure.updateRate;
timeLim = evnt.AffectedObject.timeLim;

%main ax lim
GHandle.Viewer(vIdx).timeplot.bigaxes1.XLim = timeLim;
GHandle.Viewer(vIdx).timeplot.bigaxes2.XLim = timeLim.*fs;

%string
GHandle.Viewer(vIdx).timeplot.editmin.String = timeLim(1);
GHandle.Viewer(vIdx).timeplot.editmax.String = timeLim(2);

%modify rectangle
rectangle_x = GHandle.Viewer(vIdx).timeplot.bigaxes1.XLim(1);
rectangle_y = GHandle.Viewer(vIdx).timeplot.bigaxes1.YLim(1);
rectangle_w = GHandle.Viewer(vIdx).timeplot.bigaxes1.XLim(2) - rectangle_x;
rectangle_h = GHandle.Viewer(vIdx).timeplot.bigaxes1.YLim(2) - rectangle_y;

GHandle.Viewer(vIdx).timeplot.rectangle.Position = [rectangle_x rectangle_y rectangle_w rectangle_h];

%modify text
txt_x = rectangle_w/2 + rectangle_x;
txt_y = [rectangle_y+1.3*rectangle_h rectangle_y-0.3*rectangle_h];
GHandle.Viewer(vIdx).timeplot.txt_seconds.Position = [txt_x, txt_y(1)];
GHandle.Viewer(vIdx).timeplot.txt_seconds.String = [num2str(timeLim(2)-timeLim(1)) ' s'];
GHandle.Viewer(vIdx).timeplot.txt_samples.Position = [txt_x, txt_y(2)];
GHandle.Viewer(vIdx).timeplot.txt_samples.String = [num2str(round((timeLim(2)-timeLim(1))*GHandle.CurrentDataSet.Measure.updateRate)) ' samples'];

GHandle.Viewer(vIdx).timefrequencyplot.bigaxes.XLim = timeLim;
end


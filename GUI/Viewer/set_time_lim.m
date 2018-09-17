function set_time_lim(~,evnt,GHandle)


fs = GHandle.CurrentDataSet.Measure.updateRate;
timeLim = evnt.AffectedObject.timeLim;

%main ax lim
GHandle.Viewer.timeplot.bigaxes1.XLim = timeLim;
GHandle.Viewer.timeplot.bigaxes2.XLim = timeLim.*fs;

%string
GHandle.Viewer.timeplot.editmin.String = timeLim(1);
GHandle.Viewer.timeplot.editmax.String = timeLim(2);

%modify rectangle
rectangle_x = timeLim(1);
rectangle_y = min(GHandle.CurrentDataSet.nirsdata(:));
rectangle_w = timeLim(2)-timeLim(1);
rectangle_h = max(GHandle.CurrentDataSet.nirsdata(:))-min(GHandle.CurrentDataSet.nirsdata(:));

GHandle.Viewer.timeplot.rectangle.Position = [rectangle_x rectangle_y rectangle_w rectangle_h];

%modify text
txt_x = rectangle_w/2 + rectangle_x;
txt_y = [rectangle_y+1.3*rectangle_h rectangle_y-0.3*rectangle_h];
GHandle.Viewer.timeplot.txt_seconds.Position = [txt_x, txt_y(1)];
GHandle.Viewer.timeplot.txt_seconds.String = [num2str(timeLim(2)-timeLim(1)) ' s'];
GHandle.Viewer.timeplot.txt_samples.Position = [txt_x, txt_y(2)];
GHandle.Viewer.timeplot.txt_samples.String = [num2str(round(timeLim(2)-timeLim(1)*GHandle.CurrentDataSet.Measure.updateRate)) ' samples'];


end


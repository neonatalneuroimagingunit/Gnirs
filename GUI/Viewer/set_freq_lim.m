function set_freq_lim(~,evnt,GHandle, vIdx)

freqLim = evnt.AffectedObject.freqLim;

%main ax lim
GHandle.Viewer(vIdx).spectrumplot.bigaxes1.XLim = freqLim;

GHandle.Viewer(vIdx).spectrumplot.editmin.String = freqLim(1);
GHandle.Viewer(vIdx).spectrumplot.editmax.String = freqLim(2);

rectangle_x = freqLim(1);
rectangle_y = min(GHandle.CurrentDataSet.power(:));
rectangle_w = freqLim(2)-freqLim(1);
rectangle_h = max(GHandle.CurrentDataSet.power(:))-min(GHandle.CurrentDataSet.power(:));

GHandle.Viewer(vIdx).spectrumplot.rectangle.Position = [rectangle_x rectangle_y rectangle_w rectangle_h];
end


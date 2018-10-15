function set_freq_lim(~,evnt,GHandle, vIdx)

freqLim = evnt.AffectedObject.freqLim;

%main ax lim
GHandle.Viewer(vIdx).spectrumplot.bigaxes1.XLim = freqLim;

GHandle.Viewer(vIdx).spectrumplot.editmin.String = freqLim(1);
GHandle.Viewer(vIdx).spectrumplot.editmax.String = freqLim(2);

rectangle_x = GHandle.Viewer(vIdx).spectrumplot.bigaxes1.XLim(1);
rectangle_y = GHandle.Viewer(vIdx).spectrumplot.bigaxes1.YLim(1);
rectangle_w = GHandle.Viewer(vIdx).spectrumplot.bigaxes1.XLim(2) - rectangle_x;
rectangle_h = GHandle.Viewer(vIdx).spectrumplot.bigaxes1.YLim(2) - rectangle_y;

GHandle.Viewer(vIdx).spectrumplot.rectangle.Position = [rectangle_x rectangle_y rectangle_w rectangle_h];


GHandle.Viewer(vIdx).timefrequencyplot.bigaxes.YLim = freqLim;
end


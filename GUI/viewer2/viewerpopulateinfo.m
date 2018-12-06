function viewerpopulateinfo(viewerC, GHandle, vIdx)

Label = {'Date';...
    'Note';...
    'id';...
    'Analysis' ;...
    'Time length';...
    'Sample length'};

Value = {datestr(viewerC.Analysis.date);...
    viewerC.Analysis.note; ...
    viewerC.Analysis.id;...
    viewerC.Analysis.analysis; ...
    [num2str(viewerC.Measure.timeLength) ' s'];...
    num2str(height(viewerC.Data.Time))};

nText = length(Label);
for iText = 1 : nText
    GHandle.Viewer(vIdx).InfoPanel.Text(iText) = uiw.widget.FixedText(...
        'Parent',GHandle.Viewer(vIdx).InfoPanel.VPanel,...
        'Label', Label{iText},...
        'Value', Value{iText},...
        'FontSize', viewerC.defaultFontSize, ...
        'LabelFontSize', viewerC.defaultFontSize, ...
        'ForegroundColor',viewerC.textForegroundColor,...
        'TextForegroundColor', viewerC.textForegroundColor,...
        'TextBackgroundColor', viewerC.backgroundColor,...
        'BackgroundColor',viewerC.backgroundColor);
end

end
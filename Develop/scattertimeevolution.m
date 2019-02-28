spam = GHandle.TempWindow.ProbeAxes.Children(1).SizeData;
egg = GHandle.TempWindow.ProbeAxes.Children(1).CData;
bacon = size(egg);
for aa = 1:1:10
    for ii = 0.1:0.1:1
        GHandle.TempWindow.ProbeAxes.Children(1).SizeData = spam.*ii;
        GHandle.TempWindow.ProbeAxes.Children(1).CData = rand(bacon);
        drawnow;
        %pause(0.1)
    end
end
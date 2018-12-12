function flow = createflow(obj)

outIdx = find(strcmp({obj.MethodBoxList.Tag}','Output'));
nOut = length(outIdx);
flow = cell(nOut,1);
for iOut = 1:1:nOut
    curIdx = outIdx(iOut);
    CurrentMethodBox = obj.MethodBoxList(curIdx).ArrowInput.BoxOutput;
    tempflow = [];
    while ~strcmp(CurrentMethodBox.Tag,'Input')
        tempflow = [CurrentMethodBox.Method; tempflow];
        CurrentMethodBox = CurrentMethodBox.ArrowInput.BoxOutput;
    end 
    flow{iOut} = tempflow;
end
end


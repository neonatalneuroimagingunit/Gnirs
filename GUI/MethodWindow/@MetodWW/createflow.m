%% Create Flow
function flow = createflow(obj)
outIdx = find(strcmp({obj.MethodBoxList.Tag}','Output'));
nOut = length(outIdx);
flow = cell(nOut,1);
for iOut = 1:1:nOut
    curIdx = outIdx(iOut);
    if  ~isempty(obj.MethodBoxList(curIdx).ArrowInput)
    CurrentMethodBox = obj.MethodBoxList(curIdx).ArrowInput.BoxOutput;
    else
        flow{iOut} = [];
    end
    tempflow = [];
    while ~strcmp(CurrentMethodBox.Tag,'Input') && ~isempty(CurrentMethodBox.ArrowInput)
        tempflow = [CurrentMethodBox.Method; tempflow];
        CurrentMethodBox = CurrentMethodBox.ArrowInput.BoxOutput;
    end
    if strcmp(CurrentMethodBox.Tag,'Input')
        flow{iOut} = tempflow;
    else
        flow{iOut} = [];
    end
end
end


function loadmeasure(GHandle)

probeid = [];
% add a tree branch
GHandle.Temp.loadingBar = LoadingBar;
GHandle.Temp.MainNode = uiw.widget.TreeNode(...
    'Name',repmat(char(9608),[1 10]) ,...
    'Parent',GHandle.Main.Tree.StudyTree.SelectedNodes...
    );
GHandle.Main.Tree.StudyTree.SelectedNodes.expand;

addlistener(GHandle.Temp.loadingBar,'loadingPerc','PostSet',@(src,evnt)set_tree_name(src,evnt,GHandle));
%open pharser
GHandle.Temp.fast = false;
loadimagentISS(GHandle);

%create the new variable

NewMeasure = NirsMeasure(GHandle.CurrentDataSet.Measure,...
    'studyid',GHandle.CurrentDataSet.Study.id,...
    'subjectid',GHandle.CurrentDataSet.Subject.id,...
    'note', GHandle.Temp.measureNote);

if isfield(GHandle.CurrentDataSet, 'Probe')
    probeid = GHandle.CurrentDataSet.Probe.id;
end
DataBase = GHandle.DataBase.add(NewMeasure, '', probeid);
GHandle.DataBase = DataBase;

NewAnalysis = NirsAnalysis(GHandle.CurrentDataSet.Analysis,...
    'measureid',GHandle.DataBase.Measure(end).id,...%modify this part
    'date',GHandle.CurrentDataSet.Measure.date);

DataBase = GHandle.DataBase.add(NewAnalysis);
GHandle.DataBase = DataBase;

Data.Time = GHandle.CurrentDataSet.Data;

updateRate = GHandle.CurrentDataSet.Measure.InstrumentType.UpdateRate;  %Load update rate
[power, freq] = pspectrum(Data.Time{:,2:end}, updateRate);      % Calculate The spectrum
freqTable = array2table([freq, power], ...
    'VariableNames', [{'Frequency'}, Data.Time.Properties.VariableNames(2:end)]);
Data.Frequency = freqTable;

path = GHandle.DataBase.Analysis(end).path;
if ~isempty(Data)
    save(path,'Data','-append')
end
%add to the database





tree(GHandle);
%clear temp vars
GHandle.Temp = [];
end



function set_tree_name(~, evnt, GHandle)
if (evnt.AffectedObject.loadingPerc < 1)
    ii = round(10 * evnt.AffectedObject.loadingPerc);
else
    ii = 10;
end
GHandle.Temp.MainNode.Name =  [repmat(char(9608),[1 ii]) repmat(char(9618),[1 10-ii])];
end

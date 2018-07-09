function [measureId, Study] = newmeasure(Study)
	

	% generate the new id
	measurePostFix = ['M' ,num2str(Study.nSMeasure,'%.3d')];
	measureId = [Study.id , measurePostFix ]; 
	Study.nSMeasure = Study.nSMeasure+1;
	
	posNewMeas = Study.nMeasure + 1;
	Study.Measure(posNewMeas) = GDBMeasure(measureId);

	%create the new directory
	pathMeasureAnalysis = fullfile(Study.path,'Study',[studyPostFix,'Measure']);
	mkdir(pathMeasureAnalysis)
	
	DataBase.Study(posNewStud) = GDBStudy(studyId,pathMeasureAnalysis);
	
	DataBase.save;
	
	
	
	
end


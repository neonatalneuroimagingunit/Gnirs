function [analysisId, Measure] = newanalysis(Measure)
	

	% generate the new id
	analysisPostFix = ['M' ,num2str(Measure.nSAnalisis,'%.3d')];
	analysisId = [Measure.id , analysisPostFix ]; 
	Measure.nSAnalisis = Measure.nSAnalisis+1;
	
	posNewMeas = Measure.nMeasure + 1;
	Measure.Measure(posNewMeas) = GDBMeasure(measureId);
% 	
% 	%create the new directory
% 	pathStudyMeasure = fullfile(DataBase.path,'Study',[measurePostFix,'Measure']);
% 	mkdir(pathStudyMeasure)
	
	
	
	
end


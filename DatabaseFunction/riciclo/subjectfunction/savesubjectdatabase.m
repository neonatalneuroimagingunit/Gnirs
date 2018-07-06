function [outputArg1,outputArg2] = savesubjectdatabase(Subject,DataBase)
%SAVESUBJECTDATABASE Summary of this function goes here
%   Detailed explanation goes here
	% search and change all the analysis of the subject and saveit
	
	% if is a link load it
	if ischar(DataBase)
		DataBase = loadNIRSdb(DataBase);
	end
	
	
	% chose the info to save
	Info2S
	Subject2Save = 
	
	for iMeasure = 1 : length(Subject.measureId)
		currentMeasureId = Subject.measureId(iMeasure);
		studyID = id2studyid(currentMeasureId);
		
		ListAnalysis = findanalysis('measureid',currentMeasureId,DataBase);
		
		for iAnalysis = 1 : length(ListAnalysis)
			analysisPath = fullfile(databasePath,...
									studyID,...	
									currentMeasureId,...
									ListAnalysis(iAnalysis));
			save(analysisPath,'Subject2Save');
		end
	end
end


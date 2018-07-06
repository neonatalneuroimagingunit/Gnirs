function [studyId, DataBase] = newstudy(DataBase)
	

	% generate the new id
	studyPostFix = ['U' ,num2str(DataBase.nSStudy,'%.3d')];
	studyId = [DataBase.id , studyPostFix ]; 
	DataBase.nSStudy = DataBase.nSStudy+1;
	
	posNewStud = DataBase.nStudy + 1;
	DataBase.Study(posNewStud) = GDBStudy(studyId);
	
	%create the new directory
	pathStudyMeasure = fullfile(DataBase.path,'Study',[studyPostFix,'Measure']);
	mkdir(pathStudyMeasure)
	
	DataBase.save;
	
	
	
end


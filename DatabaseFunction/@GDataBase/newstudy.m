function [studyId, DataBase] = newstudy(DataBase, varargin)
	

	% generate the new id
	studyPostFix = ['S' ,num2str(DataBase.nSStudy,'%.3d')];
	studyId = [DataBase.id , studyPostFix ]; 
	DataBase.nSStudy = DataBase.nSStudy+1;
	
	posNewStud = DataBase.nStudy + 1;
	
	
	%create the new directory
	pathStudyMeasure = fullfile(DataBase.path,'Study',[studyPostFix,'Measure']);
	mkdir(pathStudyMeasure)
	
	

	if  (nargin == 2)
		DataBase.Study(posNewStud) = GDBStudy('id',studyId,'path',pathStudyMeasure,'tag',varargin{1});
	else
		DataBase.Study(posNewStud) = GDBStudy('id',studyId,'path',pathStudyMeasure);
	end
end


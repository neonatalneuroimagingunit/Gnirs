function [DBStudy, DataBase] = newstudy(DataBase, varargin)
	

	% generate the new id
	studyPostFix = ['S' ,num2str(DataBase.nSStudy,'%.3d')];
	studyId = [DataBase.id , studyPostFix ]; 
	DataBase.nSStudy = DataBase.nSStudy+1;
	
	posNewStud = DataBase.nStudy + 1;
	
	
	%create the new directory
	pathStudy = fullfile(DataBase.path,'Study',studyPostFix);
	pathStudyMeasure = [pathStudy,'Measure'];
	mkdir(pathStudyMeasure)
	
	

	if  (nargin == 2)
		DBStudy = GDBStudy('id',studyId,'path',pathStudy,'tag',varargin{1});
	else
		DBStudy = GDBStudy('id',studyId,'path',pathStudy);
	end
	
	DataBase.Study(posNewStud) = DBStudy;
 
end
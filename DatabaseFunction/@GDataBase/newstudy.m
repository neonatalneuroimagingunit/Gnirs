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
	
	

	idx = find(contains(varargin,'tag','IgnoreCase',true), 1);
	if  ~isempty(idx)
		DBStudy = GDBStudy('id',studyId,...
						'path',pathStudy,...
						'tag',varargin{idx+1});
	else
		DBStudy = GDBStudy('id',studyId,...
						'path',pathStudy);
	end
	
	DataBase.Study(posNewStud) = DBStudy;
 
end
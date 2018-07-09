function [subjectId, DataBase] = newsubjecttemplate(DataBase, varargin)
	

	% generate the new id
	subjectpostfix = ['U' ,num2str(DataBase.nSSubject,'%.3d')];
	subjectId = [DataBase.id , subjectpostfix]; 
	DataBase.nSSubject = DataBase.nSSubject+1;
	
	posNewSubj = DataBase.nSubject + 1;
	
	subjectPath = fullfile(DataBase.path, 'Subject',subjectpostfix);
	
	if  (nargin == 2)
		DataBase.Subject(posNewSubj) = GDBSubject('id',subjectId,'template',true,...
				'tag',varargin{1}, 'path',subjectPath);
	else
		DataBase.Subject(posNewSubj) = GDBSubject('id',subjectId,'template',true,...
				'path',subjectPath);
	end
	
	
end


function [DBSubject, DataBase] = newsubject(DataBase, varargin)
	

	% generate the new id
	subjectpostfix = ['U' ,num2str(DataBase.nSSubject,'%.3d')];
	subjectId = [DataBase.id , subjectpostfix]; 
	DataBase.nSSubject = DataBase.nSSubject+1;
	
	posNewSubj = DataBase.nSubject + 1;
	
	subjectPath = fullfile(DataBase.path, 'Subject',subjectpostfix);
	
	if  (nargin == 2)
		DBSubject = GDBSubject('id',subjectId,...
				'tag',varargin{1}, 'path',subjectPath);
	else
		DBSubject = GDBSubject('id',subjectId,...
				'path',subjectPath);
	end
	
	DataBase.Subject(posNewSubj) = DBSubject;
end


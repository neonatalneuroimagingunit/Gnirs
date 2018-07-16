function [subjectId, DataBase] = newsubject(DataBase, varargin)
	

	% generate the new id
	subjectpostfix = ['U' ,num2str(DataBase.nSSubject,'%.3d')];
	subjectId = [DataBase.id , subjectpostfix]; 
	DataBase.nSSubject = DataBase.nSSubject+1;
	
	posNewSubj = DataBase.nSubject + 1;
	
	subjectPath = fullfile(DataBase.path, 'Subject',subjectpostfix);
	
	templateFlag = any(contains(varargin,'template','IgnoreCase',true));
	 
	idx = find(contains(varargin,'tag','IgnoreCase',true), 1);
	if  ~isempty(idx)
		DBSubject = GDBSubject('id',subjectId,...
							'template',templateFlag,...
							'path',subjectPath,...
							'tag',varargin{idx+1});
	else
		DBSubject = GDBSubject('id',subjectId,...
							'template',templateFlag,...
							'path',subjectPath);
	end
	
	DataBase.Subject(posNewSubj) = DBSubject;
end


function [subjectId, DataBase] = newsubject(DataBase)
	

	% generate the new id
	subjectId = [DataBase.id , 'U' ,num2str(DataBase.nSSubject,'%.3d')]; 
	DataBase.nSSubject = DataBase.nSSubject+1;
	
	posNewSubj = DataBase.nSubject + 1;
	DataBase.Subject(posNewSubj) = GDBSubject(subjectId);
	
	DataBase.save;
	
	
	
end


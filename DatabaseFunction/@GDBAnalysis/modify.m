function DBAnalysis = modify(DBAnalysis,NewAnalysis)
%ADDMODIFYSUBJECT add or modify a subject present in the database


	if (strcmp(DBAnalysis.id,NewAnalysis.id) || isempty(NewAnalysis.id))
	
		OldAnalysis = DBAnalysis.load;

		Anlaysis = NewAnalysis;
		if isempty(NewAnalysis.id)
			Anlaysis.id = OldAnalysis.id;
		end
	
		if isempty(NewAnalysis.date)
			Anlaysis.date = OldAnalysis.date;
		end

		if isempty(NewAnalysis.analysis)
			Anlaysis.analysis = OldAnalysis.analysis;
		end

		if isempty(NewAnalysis.SimplyData)
			Anlaysis.SimplyData = OldAnalysis.SimplyData;
		end
		
		if isempty(NewAnalysis.note)
			Anlaysis.note = OldAnalysis.note;
		end

		save(DBAnalysis.path,'Anlaysis');
		
	else 
		error('id not match')
	end
end

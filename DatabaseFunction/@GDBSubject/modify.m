function DataBase = modify(DBSubject,NewSubject)
%ADDMODIFYSUBJECT add or modify a subject present in the database


	if strcmp(DBSubject.id,NewSubject.id)
	
	OldSubject = DBSubject.load;
	

		Subject = NewSubject;

		%value cannot be change
		Subject.template = OldSubject.template;


		% assign all nonspecify value to the old value
		if isempty(NewSubject.measureId)
			Subject.measureId = OldSubject.measureId;
		end

		if isempty(NewSubject.name)
			Subject.name = OldSubject.name;
		end

		if isempty(NewSubject.surName)
			Subject.surName = OldSubject.surName;
		end

		if isempty(NewSubject.birthDay)
			Subject.birthDay = OldSubject.birthDay;
		end

		if isempty(NewSubject.note)
			Subject.note = OldSubject.note;
		end

		if isempty(NewSubject.Info)
			Subject.Info = OldSubject.Info;
		else
			% check all the field of the new and assign to the old
			oldFieldNames = fieldnames(OldSubject.Info);
			newFieldNames = fieldnames(NewSubject.Info);

			oldFieldNames2Save = oldFieldNames(~ismember(oldFieldNames , newFieldNames));
			for iField = 1 : length(oldFieldNames2Save)
				Subject.Info.(oldFieldNames2Save{iField}) = OldSubject.Info(oldFieldNames2Save{iField});
			end
		end

		save(DBSubject.path,'Subject');
		
	end
end

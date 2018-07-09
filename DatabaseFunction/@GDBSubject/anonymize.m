function anonymize(DBSubject, field)
%AanonimizeSUBJECT 

	
	Subject = DBSubject.load;
	
	% check fields to erase
	if any(strcmpi(field,'name'))
		Subject.name = [];
		% erase tag in database (usual the name)
		DBSubject.tag = [];
	end
	
	
	if any(strcmpi(field,'surname'))
		Subject.surName = [];
	end
	
	
	if any(strcmpi(field,'birthday'))
		Subject.birthDay = [];
	end
	
	
	if any(strcmpi(field,'note'))
		Subject.note = [];
	end
	
	if any(strcmpi(field,'info'))
		Subject.info = [];
	else
		% check all the field of the study to erase
		fieldNames = fieldnames(Subject.Info);

		fieldNames2Erase = fieldNames(~ismember(fieldNames , field));
		for iField = 1 : length(fieldNames2Erase)
			Subject.Info.(fieldNames2Erase{iField}) = [];
		end
	end
	
	
	DBSubject.substitute(Subject);
end

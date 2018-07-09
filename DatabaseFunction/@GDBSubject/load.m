function Subject = load(DBSubject)

	if DBSubject.template
		temp = load(DBSubject.path,'SubjectTemplate');
		Subject = temp.SubjectTemplate;
	else
		temp = load(DBSubject.path,'Subject');
		Subject = temp.Subject;
	end

end


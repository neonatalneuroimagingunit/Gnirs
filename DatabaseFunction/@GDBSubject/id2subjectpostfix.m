function postFix = id2subjectpostfix(id)
lengthDataBaseId = 7;
lengthStudyId = 11;

	if (ischar(id) && length(id)>=lengthStudyId)
		postFix = id((lengthDataBaseId+1):lengthStudyId);
	end
end


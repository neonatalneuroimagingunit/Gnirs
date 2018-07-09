function studyId = id2studyid(id)
lengthStudyId = 11;

	if (ischar(id) && length(id)>=lengthStudyId)
		studyId = id(1:lengthStudyId);
	end
end


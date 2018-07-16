function postFix = id2postfix(id)
lengthDataBaseId = 7;
lengthAnalysisId = 14;

	if (ischar(id) && length(id)>=lengthAnalysisId)
		postFix = id((lengthDataBaseId+1):lengthAnalysisId);
	end
end


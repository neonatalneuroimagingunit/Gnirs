function postFix = id2measurepostfix(id)
lengthDataBaseId = 7;
lengthMeasureId = 14;

	if (ischar(id) && length(id)>=lengthMeasureId)
		postFix = id((lengthDataBaseId+1):lengthMeasureId);
	end
end


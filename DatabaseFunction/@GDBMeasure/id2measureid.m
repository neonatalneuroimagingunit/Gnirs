function measureId = id2measureid(id)
lengthMeasureId = 15;

	if (ischar(id) && length(id)>=lengthMeasureId)
		measureId = id(1:lengthMeasureId);
	end
end


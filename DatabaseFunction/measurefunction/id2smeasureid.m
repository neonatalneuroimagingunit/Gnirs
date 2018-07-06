function measureId = id2smeasureid(id)
%ID2STUDYID Summary of this function goes here
%   Detailed explanation goes here
	if (length(id)>=15)
		measureId = id(1:15);
	else
		error('id not valid')
	end
end


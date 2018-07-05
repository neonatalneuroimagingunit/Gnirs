function studyId = id2studyid(id)
%ID2STUDYID Summary of this function goes here
%   Detailed explanation goes here
	if (length(id)>=11)
		studyId = id(1:11);
	else
		error('id not valid')
	end
end


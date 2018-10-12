function pointFound = pointsrelpos(pathPoints,relLength, percentage)
%POINTSRELPOS Summary of this function goes here
%   Detailed explanation goes here
nPoints = length(percentage);
pointFound = zeros(nPoints, size(pathPoints,2));

for iPoints = 1 : 1 : nPoints
	idxPathSup = relLength > percentage(iPoints);
	idxSup = find(idxPathSup, 1,'first');
	if ~isempty(idxSup)
		if idxSup > 1
			coeff = (percentage(iPoints) - relLength(idxSup-1))...
				/ (relLength(idxSup) - relLength(idxSup-1));
			pointFound(iPoints, :) = coeff.*(pathPoints(idxSup, :) - pathPoints(idxSup-1, :))...
				+ (pathPoints(idxSup-1, :));
		else 
			pointFound(iPoints, :) = pathPoints(1,:);
		end
	else
		pointFound(iPoints, :) = pathPoints(end,:);
	end
end

end


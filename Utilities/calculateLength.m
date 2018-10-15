function [totalLength,cumulativeLength] = calculateLength(points)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

nPoints = size(points,1);
cumulativeLength = zeros(nPoints,1);

for iPonts = 1:1:(nPoints-1)
	pt1 = points(iPonts,:);
	pt2 = points(iPonts+1 ,:);
	tempLength = vecnorm(pt1 - pt2);
	cumulativeLength(iPonts+1) = cumulativeLength(iPonts) + tempLength;
end
totalLength = cumulativeLength(end);
cumulativeLength = cumulativeLength./totalLength;

end


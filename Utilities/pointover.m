function pointover = pointover(points,coffplane)
%POINTOVER Summary of this function goes here
%   Detailed explanation goes here

pointover = ((points(:,1)*coffplane(1) + ...
	points(:,2)*coffplane(2) + ...
	points(:,3)*coffplane(3) + ...
	coffplane(4)) > 0);

end


function pointover = positivepoint(points, linecoff, lineinters)
%POINTOVER Summary of this function goes here
%   Detailed explanation goes here
linecoff = repmat(linecoff,[size(points,1),1]);
pointover = (dot(points  - lineinters, linecoff,2) > 0);

distance = vecnorm(points - lineinters, 2, 2);
pointover = pointover & (distance / max(distance(pointover)) > 0.9 );

end


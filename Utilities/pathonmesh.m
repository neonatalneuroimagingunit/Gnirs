function [pathPoints, pathLength, relativeLength] = pathonmesh(meshPoints, firstPoint, middlePoint , lastPoint, nStep)
%PATHONMESH Summary of this function goes here
%   Detailed explanation goes here
nProxPoint = 30;

centralPoint = points2mdpoints(firstPoint, lastPoint, middlePoint);

plaincoff = points2plane(firstPoint, middlePoint, lastPoint);
[linecoff,lineinters] = linecoffgen(plaincoff, centralPoint, firstPoint, nStep);

pathPoints = zeros(nStep,3);

for ii = 1 : nStep
	
	nearPoints = nearest2line(meshPoints,linecoff(ii,:), lineinters(ii,:), nProxPoint);
	nearPoints = nearPoints(positivepoint(nearPoints,linecoff(ii,:),lineinters(ii,:)),:);
	
	if size(nearPoints,1) > 2
		nearPoints = nearest2line(nearPoints,linecoff(ii,:), lineinters(ii,:), 3);
		coffplane = points2plane(nearPoints(1,:),nearPoints(2,:),nearPoints(3,:));
		coffplane(4) = -coffplane(4);
		pathPoints(ii,:) = planelineintersec(coffplane, linecoff(ii,:), lineinters(ii,:));
	end
	
end

pathPoints = pathPoints(any(pathPoints,2),:);
[pathLength, relativeLength] = calculateLength(pathPoints);

end


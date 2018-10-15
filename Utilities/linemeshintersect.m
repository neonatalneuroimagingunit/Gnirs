function intersectionPoints = linemeshintersect(meshPoints,linecoff,lineinters)
%LINEMESHINTERSECT Summary of this function goes here
%   Detailed explanation goes here

nofLines = size(linecoff);

intersectionPoints = zeros(nofLines);

nProxPoint = 30;

for ii = 1 : nofLines(1)
	

	
	
	nearPoints = nearest2line(meshPoints,linecoff(ii,:), lineinters(ii,:), nProxPoint);
	nearPoints = nearPoints(positivepoint(nearPoints,linecoff(ii,:),lineinters(ii,:)),:);
	
	if size(nearPoints,1) > 2
		nearPoints = nearest2line(nearPoints,linecoff(ii,:), lineinters(ii,:), 3);
		meanPoint = mean(nearPoints,1);
		%coffplane = points2plane(nearPoints(1,:),nearPoints(2,:),nearPoints(3,:));
		%pathPoints(ii,:) = planelineintersec(coffplane, linecoff(ii,:), lineinters(ii,:));
		intersectionPoints(ii,:) = nearestlinepoint(meanPoint, linecoff(ii,:), lineinters(ii,:));
		
	end
	
end

intersectionPoints = intersectionPoints(any(intersectionPoints,2),:);
end


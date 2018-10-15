function [pathPoints, pathLength, relativeLength] = pathonmesh(meshPoints, firstPoint, middlePoint , lastPoint, nStep)
%PATHONMESH Summary of this function goes here
%   Detailed explanation goes here


centralPoint = points2mdpoints(firstPoint, lastPoint, middlePoint);

plaincoff = points2plane(firstPoint, middlePoint, lastPoint);

[linecoff,lineinters] = linecoffgen(plaincoff, centralPoint, firstPoint, nStep);

pathPoints = linemeshintersect(meshPoints,linecoff,lineinters);

[pathLength, relativeLength] = calculateLength(pathPoints);

end


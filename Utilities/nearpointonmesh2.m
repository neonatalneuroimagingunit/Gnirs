function pointList = nearpointonmesh2(meshPoints,centralPoint, referencePoint, middlePoint)
%NEARPOINTONMESH Summary of this function goes here
%   Detailed explanation goes here

nLine =10;

if nargin == 3 
	middlePoint = [0 0 0];
end
% found the 2 lines coff
centralLinecoff = point2line(centralPoint,middlePoint);
lineGen1coef = point2line(referencePoint(1,:),middlePoint);

% rotatate the reference line arround the central line
lineGen2coef =  point2line(referencePoint(2,:),middlePoint);

% again
lineGen3coef =  point2line(referencePoint(4,:),middlePoint);

% another time
 lineGen4coef =  point2line(referencePoint(3,:),middlePoint);
% generate the line
alpha = linspace(-1,1,nLine);

[alpha, beta] = meshgrid(alpha, alpha);

alpha = alpha(:);
beta = beta(:);
lineCoff = beta.*lineGen1coef + (1-beta).*lineGen2coef + alpha.*lineGen1coef + (1-alpha).*lineGen4coef;

% line mesh intersect

lineInt = repmat(middlePoint, [size(lineCoff,1), 1]);

pointList = linemeshintersect(meshPoints,lineCoff,lineInt);

end
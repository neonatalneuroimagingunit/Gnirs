function points = nearest2line(meshPoint,linecoff, lineint, N)
%NEAREST2LINE Summary of this function goes here
%   Detailed explanation goes here


x1 = repmat(lineint , [size(meshPoint,1),1]);
x2 = linecoff + lineint;

dist2 = vecnorm(cross((x1 - x2),(x1 - meshPoint)),2,2)./vecnorm(lineint - x2);
  
[~ , idx] = sort(dist2);

points = meshPoint(idx(1:N),:);
end


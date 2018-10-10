function points = nearest2line(meshPoint,linecoff, lineint, N)
%NEAREST2LINE Summary of this function goes here
%   Detailed explanation goes here

dist2 = (linecoff(2).*(meshPoint(:,1)-lineint(1))-linecoff(1).*(meshPoint(:,2)-lineint(2))).^2 ...
	  + (linecoff(3).*(meshPoint(:,1)-lineint(1))-linecoff(1).*(meshPoint(:,3)-lineint(3))).^2;
  
[~ , idx] = sort(dist2);

points = meshPoint(idx(1:N),:);
end


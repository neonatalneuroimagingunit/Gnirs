function [planeCoff, eigVal] = planefitfromcloud(points)
% points is a vector NxD where N is the number of point and D the
% dimensionality of the space where the points is defined

%by Nadir

% find a point of the plane

p = mean(points,1);
% calculate the difference between the points and p
R = points - p;
% calculate the covariance matrix and its eigenvector/value
[eigVec, eigVal] = eig(R'*R);

planeCoff = eigVec(:,1);
planeCoff(4) = -dot(planeCoff,p);
end


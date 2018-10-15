function [linecoff,lineinters] = linecoffgen(plaincoff, point0, pointA, N)
% LINECOFFGEN Summary of this function goes here
% 
% Detailed explanation goes here
	lineinters = repmat(point0,[N,1]);


	line1(1) = 1;
	line1(2) = (pointA(2)-point0(2))/(pointA(1)-point0(1));
	line1(3)= (pointA(3)-point0(3))/(pointA(1)-point0(1));
	
	line2 = cross(line1,plaincoff(1:3));
	
	line1 = line1./vecnorm(line1);
	line2 = line2./vecnorm(line2);
	
	line1 = repmat(line1,[N,1]);
	line2 = repmat(line2,[N,1]);
	alpha = linspace(0,pi,N);
	
	


	
	
	alpha2 = -sin(alpha);
	alpha1 = cos(alpha);
	
	alpha1 = repmat(alpha1', [1,3]);
	alpha2 = repmat(alpha2', [1,3]);
	
	
	linecoff =(line1.*(alpha1)) +  (line2 .* (alpha2));
        
        
end
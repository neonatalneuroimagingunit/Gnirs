function [linecoff,lineinters] = linecoffgen(plaincoff, pointcord,N)
% LINECOFFGEN Summary of this function goes here
% 
% Detailed explanation goes here
	lineinters = repmat(pointcord,[N,1]);
	alpha = linspace(-1,1,N);
	linecoff(:,1) = alpha;
        linecoff(:,2) = (1-abs(alpha));
        linecoff(:,3) = -(linecoff(:,1).*plaincoff(1)+linecoff(:,2).*plaincoff(2))/plaincoff(3);
        
        
end
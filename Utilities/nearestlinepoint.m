function xc = nearestlinepoint(x0, linecoff, lineinters)
%PT2PTBUONO Summary of this function goes here
%   Detailed explanation goes here


d = -(dot(linecoff,x0)); % selezione il piano passante per x3


k = -(dot(linecoff,lineinters) + d)./dot(linecoff, linecoff); %intersezione piano retta
xc(1) = k.*linecoff(1) + lineinters(1);
xc(2) = k.*linecoff(2) + lineinters(2);
xc(3) = k.*linecoff(3) + lineinters(3);
end


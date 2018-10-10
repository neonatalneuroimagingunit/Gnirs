function x = planelineintersec(plaincoff, linecoff, lineinters)
%PLANELINEINTERSEC Summary of this function goes here
%   plain -> Ax+By+Cz+D = 0 
%   line -> x = a k + x0
%			y = b k + y0
%			z = c k + z0
% plaincoff = [A B C D]
% linecoff = [a b c]
% lineinters = [x0 y0 z0]

k = -(dot(plaincoff(1:3),lineinters)+plaincoff(4))./dot(plaincoff(1:3),linecoff);

x(1) = linecoff(1).* k + lineinters(1);
x(2) = linecoff(2).* k + lineinters(2);
x(3) = linecoff(3).* k + lineinters(3);
end

% dtjrszmng
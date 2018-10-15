function [xp] = points2mdpoints(x1,x2,x3)
% punto sulla retta passante per x1 x2 
% tale che la testta che passa per esso e x3 e' perpendicoalre 
% alla retta che passa per x1 x2


%trovo le equazioni parametriche della retta passante per x1 x2
[linecoff,lineintes] = point2line(x1,x2);
plaincoff(1:3) = linecoff;
% perpendicolare alla retta 
plaincoff(4) = -dot(linecoff,x3); % selezione il piano passante per x3
xp = planelineintersec(plaincoff, linecoff, lineintes);

end %gg

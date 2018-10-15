function [planeCoff] = findortogonalplane(planePoint,otherPoint)


%trovo le equazioni parametriche della retta passante per x1 x2
% x = ak + x0
% y = bk + y0

planeCoff(1:3) = point2line(planePoint,otherPoint);

% [a,b,c] è il vettore perpendicolare al piano perpendicolare alla retta 

planeCoff(4) = -dot(planeCoff,planePoint);

end


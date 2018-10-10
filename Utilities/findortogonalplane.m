function [planeCoff] = findortogonalplane(planePoint,otherPoint)

if (planePoint(1) == otherPoint(1))
	msgbox('Pagno non lo ha ancora sistemato')
end
%trovo le equazioni parametriche della retta passante per x1 x2
% x = ak + x0
% y = bk + y0
planeCoff(1) = 1; 
planeCoff(2) = (planePoint(2)-otherPoint(2))./(planePoint(1)-otherPoint(1)); % [a,b,c] è il vettore perpendicolare al piano
planeCoff(3) = (planePoint(3)-otherPoint(3))./(planePoint(1)-otherPoint(1)); % perpendicolare alla retta 
%x0(1) = 0; pongo arbitrariamente

planeCoff(4) = -(planePoint(1) + planeCoff(2).*planePoint(2) + planeCoff(3).*planePoint(3));

end


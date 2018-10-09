function [xp] = points2mdpoints(x1,x2,x3)

if (x1(1) == x2(1))
	msgbox('Pagno non lo ha ancora sistemato')
end
%trovo le equazioni parametriche della retta passante per x1 x2
% x = ak + x0
% y = bk + y0
% a = 1; pongo arbitrariamente
b = (x1(2)-x2(2))./(x1(1)-x2(1)); % [a,b,c] è il vettore perpendicolare al piano
c = (x1(3)-x2(3))./(x1(1)-x2(1)); % perpendicolare alla retta 
d = -(x3(1) + b.*x3(2) + c.*x3(3)); % selezione il piano passante per x3
%x0(1) = 0; pongo arbitrariamente
x0(2) = -x2(1).*b + x2(2); % calcolo gli ultimi coefficenti della retta
x0(3) = -x2(1).*c + x2(3);

xp(1) = -( x0(2).*b + x0(3).*c +d)./(1 + b.^2 + c.^2); %intersezione piano retta
xp(2) = xp(1).*b + x0(2);
xp(3) = xp(1).*c + x0(3);
end %gg

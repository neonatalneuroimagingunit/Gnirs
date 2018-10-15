function Cz = findCz(meshPoints, Iz, Nz, RPA, LPA)
%FINDCZ Summary of this function goes here
%   Detailed explanation goes here


nApprox = 20;
nStep = 500;
%find a point on upper part of the mesh 

%Cz first approx
middlePoint = mean([Iz;Nz;RPA;LPA]);
Cz = linemeshintersect(meshPoints,[0 0 1],middlePoint);


for iApprox = 1 : nApprox
	[pathIzCzNzPoints, ~, pathIzCzNzrelativeLength] = pathonmesh(meshPoints, Iz, Cz , Nz, nStep);
	Cz = pointsrelpos(pathIzCzNzPoints, pathIzCzNzrelativeLength, 0.5);
	%plot3(Cz(:,1),Cz(:,2),Cz(:,3),'+r')

	[pathIzCzNzPoints, ~, pathIzCzNzrelativeLength] = pathonmesh(meshPoints, RPA, Cz , LPA, nStep);
	Cz = pointsrelpos(pathIzCzNzPoints, pathIzCzNzrelativeLength, 0.5);
	%plot3(Cz(:,1),Cz(:,2),Cz(:,3),'*r')
end

end


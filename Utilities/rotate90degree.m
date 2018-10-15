function rotatedPoint = rotate90degree(point2Rotate,rotationAxes)
%ROTATE90DEGREE Summary of this function goes here
%   Detailed explanation goes here
rotationAxes = rotationAxes/norm(rotationAxes);

ii = rotationAxes(1);
jj = rotationAxes(2);
kk = rotationAxes(3);
rotationMatrix = [	ii*ii,		ii*jj-kk,	ii*kk+jj;...
					ii*jj+kk,	jj*jj,		jj*kk-ii;...
					ii*kk-jj,	jj*kk+ii,	kk*kk];
				
				
rotatedPoint = rotationMatrix*point2Rotate(:);

rotatedPoint = rotatedPoint';
end


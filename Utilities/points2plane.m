function [coff] = points2plane(x1,x2,x3)
coff = cross(x2-x1, x3-x1);
coff(4) = dot(coff,x1);
end

function [linecoff,lineintes] = point2line(x1,x0)
% x0 is also the line lineintes

lineintes = x0;
linecoff = x1 - x0;
linecoff=linecoff/norm(linecoff);

end


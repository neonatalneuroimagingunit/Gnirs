function h = frecciona(point,vector,varargin)

% style ('up' or 'down')
% size (scalar)
% color (RGB triplet)
% arrowsize (2x1 array, length width)

propertyNames = {'EdgeColor'};
propertyValues = {'none'};    
for nArg = 1:2:nargin-2
    switch lower(varargin{nArg})
        case 'color'
            propertyNames = [propertyNames, {'Facecolor'}];
            propertyValues = [propertyValues, varargin(nArg+1)];
        case 'style'
            if ischar(varargin{nArg+1})
                style = varargin{nArg+1};
            else
                style = 'up';
            end
        case 'size'
            if isnumeric(varargin{nArg+1})
                arrowSize = varargin{nArg+1};
            else
                arrowSize = [1 0.05];
            end
        otherwise
            propertyNames = [propertyNames, varargin(nArg)];
            propertyValues = [propertyValues(:), varargin(nArg+1)];
    end
end     

vector = vector/norm(vector);
vector = arrowSize(1).*vector;



%% default parameters
stemWidth = arrowSize(2);
tipWidth = 3*stemWidth;
tipAngle = 22.5/180*pi;
tipLength = tipWidth/tan(tipAngle/2);
ppsc = 50;  % (points per small circle)
ppbc = 250; % (points per big circle)
%% ensure column vectors
p1 = point;
p2 = point+vector;


if strcmp(style,'down')
    temp = p2;
    p2 = p1;
    p1 = temp;
end

p1 = p1(:);
p2 = p2(:);
%% basic lengths and vectors
x = (p2-p1)/norm(p2-p1); % (unit vector in arrow direction)
y = cross(x,[0;0;1]);    % (y and z are unit vectors orthogonal to arrow)
if norm(y)<0.1
    y = cross(x,[0;1;0]);
end
y = y/norm(y);
z = cross(x,y);
z = z/norm(z);
%% basic angles
theta = 0:2*pi/ppsc:2*pi; % (list of angles from 0 to 2*pi for small circle)
sintheta = sin(theta);
costheta = cos(theta);
upsilon = 0:2*pi/ppbc:2*pi; % (list of angles from 0 to 2*pi for big circle)
sinupsilon = sin(upsilon);
cosupsilon = cos(upsilon);
%% initialize face matrix
f = NaN([ppsc+ppbc+2 ppbc+1]);
%% normal arrow
if norm(p2-p1)>tipLength
    % vertices of the first stem circle
    for idx = 1:ppsc+1
        v(idx,:) = p1 + stemWidth*(sintheta(idx)*y + costheta(idx)*z);
    end
    % vertices of the second stem circle
    p3 = p2-tipLength*x;
    for idx = 1:ppsc+1
        v(ppsc+1+idx,:) = p3 + stemWidth*(sintheta(idx)*y + costheta(idx)*z);
    end
    % vertices of the tip circle
    for idx = 1:ppbc+1
        v(2*ppsc+2+idx,:) = p3 + tipWidth*(sinupsilon(idx)*y + cosupsilon(idx)*z);
    end
    % vertex of the tiptip
    v(2*ppsc+ppbc+4,:) = p2;
    % face of the stem circle
    f(1,1:ppsc+1) = 1:ppsc+1;
    % faces of the stem cylinder
    for idx = 1:ppsc
        f(1+idx,1:4) = [idx idx+1 ppsc+1+idx+1 ppsc+1+idx];
    end
    % face of the tip circle
    f(ppsc+2,:) = 2*ppsc+3:(2*ppsc+3)+ppbc;
    % faces of the tip cone
    for idx = 1:ppbc
        f(ppsc+2+idx,1:3) = [2*ppsc+2+idx 2*ppsc+2+idx+1 2*ppsc+ppbc+4];
    end
%% only cone v
else
    tipWidth = 2*sin(tipAngle/2)*norm(p2-p1);
    % vertices of the tip circle
    for idx = 1:ppbc+1
        v(idx,:) = p1 + tipWidth*(sinupsilon(idx)*y + cosupsilon(idx)*z);
    end
    % vertex of the tiptip
    v(ppbc+2,:) = p2;
    % face of the tip circle
    f(1,:) = 1:ppbc+1;
    % faces of the tip cone
    for idx = 1:ppbc
        f(1+idx,1:3) = [idx idx+1 ppbc+2];
    end
end
%% draw
fv.faces = f;
fv.vertices = v;
h = patch(fv);
for propno = 1:numel(propertyNames)
    try
        set(h,propertyNames{propno},propertyValues{propno});
    catch
    end
end

end
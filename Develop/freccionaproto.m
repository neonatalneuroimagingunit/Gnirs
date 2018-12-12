function h = frecciona(point,vector,varargin)

% style ('up' or 'down')
% size (scalar)
% color (RGB triplet)
% arrowsize (2x1 array, length width)

%% default parameters
parent = gca;
color = 'g';
tipColor = [];
stemColor = [];
stemTipRatio = 4;
stemLength = [];
tipLength = [];
style = 'down';
totalLength = [];
lengthWidthRatio = 25;
stemWidth = [];
tipWidth = [];
tipAngle = 22.5/180*pi;
pointSmallCircle = 50;  % (points per small circle)
pointBigCircle = 250; % (points per big circle)


for nArg = 1:2:nargin-2
    switch lower(varargin{nArg})
        case 'parent'
            parent = varargin{nArg+1};
        case 'color'
            color = varargin{nArg+1};
        case 'tipcolor'
            tipColor = varargin{nArg+1};
        case 'stemcolor'
            stemColor = varargin{nArg+1};
        case 'stemtipratio'
            stemTipRatio = varargin{nArg+1};
        case 'stemlength'
            stemLength = varargin{nArg+1};
        case 'tiplength'
            tipLength = varargin{nArg+1};
        case 'style'
            style = varargin{nArg+1};
        case 'totallength'
            totalLength = varargin{nArg+1};
        case 'lengthwidthratio'
            lengthWidthRatio = varargin{nArg+1};
        case 'stemwidth'
            stemWidth = varargin{nArg+1};
        case 'tipwidth'
            tipWidth = varargin{nArg+1};
        case 'tipangle'
            tipAngle = varargin{nArg+1};
        case 'pointsmallcircle'
            pointSmallCircle = varargin{nArg+1};
        case 'pointbigcircle'
            pointBigCircle = varargin{nArg+1};
            
        otherwise
            warning(['propretis' varargin{nArg} 'not exist'])
    end
end

%% fuond tip length and total length
if isempty(totalLength)
    if isempty(tipLength)
        if isempty(stemLength)
            totalLength = vecnorm(vector);
            v = vector(:)';
            tipLength = totalLength./(stemTipRatio + 1);
        else
            totalLength = vecnorm(vector);
            tipLength = totalLength - stemLength;
            v = vector(:)';
        end
    else
        if isempty(stemLength)
            totalLength = vecnorm(vector);
            v = vector(:)';
        else
            totalLength = stemLength + tipLength;
            v = totalLength.*vector(:)'./vecnorm(vector);
        end
    end
else
    if ~isempty(tipLength)
        v = totalLength.*vector(:)'./vecnorm(vector);
    elseif ~isempty(stemLength)
        tipLength = totalLength - stemLength;
        v = totalLength.*vector(:)'./vecnorm(vector);
    else
        tipLength = totalLength./(stemTipRatio + 1);
        v = totalLength.*vector(:)'./vecnorm(vector);
    end
    
end

if isempty(tipWidth)
    tipWidth = tan(tipAngle)*tipLength;
end
if isempty(stemWidth)
    stemWidth = totalLength/lengthWidthRatio;
end

%% ensure column vectors

if strcmp(style,'down')
    p2 = point(:)';
    p1 = p2-v;
else
    p1 = point(:)';
    p2 = p1+v;
end

%% basic lengths and vectors
x = v/norm(v); % (unit vector in arrow direction)
y = cross(x,[0;0;1]);
if norm(y)<0.1
    y = cross(x,[0;1;0]);
end
y = y/norm(y);
z = cross(x,y);


%% basic angles
theta = 0:(2*pi/pointSmallCircle):2*pi; % (list of angles from 0 to 2*pi for small circle)
sintheta = sin(theta);
costheta = cos(theta);
upsilon = 0:(2*pi/pointBigCircle):2*pi; % (list of angles from 0 to 2*pi for big circle)
sinupsilon = sin(upsilon);
cosupsilon = cos(upsilon);

%% initialize face matrix
f = NaN([pointSmallCircle+pointBigCircle+2, pointBigCircle+1]);

%% normal arrow
if norm(p2-p1)>tipLength
    % vertices of the first stem circle
    verStem1 = p1 + stemWidth*(sintheta(:)*y + costheta(:)*z);
    
    % vertices of the second stem circle
    p3 = p2-tipLength*x;
    verStem2 = p3 + stemWidth*(sintheta(:)*y + costheta(:)*z);
    
    % vertices of the tip circle
    verTipC = p3 + tipWidth*(sinupsilon(:)*y + cosupsilon(:)*z);
    
    % vertex of the tiptip
    verTipT = p2;
    
    v = [verStem1; verStem2; verTipC; verTipT];
    
    % face of the stem circle
    f(1,1:pointSmallCircle+1) = 1:pointSmallCircle+1;
    
    % faces of the stem cylinder
    temp = (1:1:1+pointSmallCircle)';
    f(1:1:1+pointSmallCircle,1:4) = [temp mod(temp,51)+1 pointSmallCircle+1+mod(temp,51)+1 pointSmallCircle+1+temp];
    
    % face of the tip circle
    f(pointSmallCircle+2,:) = 2*pointSmallCircle+3:(2*pointSmallCircle+3)+pointBigCircle;
    % faces of the tip cone
    temp = (1:pointBigCircle)';
    f(pointSmallCircle+2+temp,1:3) = [2*pointSmallCircle+2+temp 2*pointSmallCircle+2+temp+1 2*pointSmallCircle+pointBigCircle+4*ones(size(temp))];
    
    %% only cone v
else
    tipWidth = 2*sin(tipAngle/2)*norm(p2-p1);
    % vertices of the tip circle
    for idx = 1:pointBigCircle+1
        v(idx,:) = p1 + tipWidth*(sinupsilon(idx)*y + cosupsilon(idx)*z);
    end
    % vertex of the tiptip
    v(pointBigCircle+2,:) = p2;
    % face of the tip circle
    f(1,:) = 1:pointBigCircle+1;
    % faces of the tip cone
    for idx = 1:pointBigCircle
        f(1+idx,1:3) = [idx idx+1 pointBigCircle+2];
    end
end

%% draw

h = patch('Parent',parent,'Faces', f, 'Vertices', v,'faceColor',color,'edgeColor',color);

end
function PlotHandle = plotsensitivityslice(HeadMesh, varargin)
Parent
SegmentationLabel


for iArgIn = 1 : 1: nargin
    Parent
    
end



no = HeadMesh.node(:,1:3);
segmentationLabel = HeadMesh.node(:,4);
% sensitivity = log(abs(sum(fluxx.data,2))/max(abs(sum(fluxx.data,2))));
% 
% segmentationLabel(sensitivity > -8) = sensitivity(sensitivity > -8);

el = HeadMesh.elem(:,1:4);

%calculate the distance from the plane
dist = no(:,1);
% get all the edges of the mesh
meshEdge = [el(:,[1,2]);el(:,[1,3]);el(:,[1,4]);
    el(:,[2,3]);el(:,[2,4]);el(:,[3,4])];

% calculate the distance of the edge
sDist = sign(dist(meshEdge));
mask = sDist(:,1) ~= sDist(:,2);
cutEdges = find(mask);

newEdge = meshEdge(mask,:);
% wEdge = diff(dist(newEdge),1,2);
wEdge = abs(dist(newEdge(:,1))./diff(dist(newEdge),1,2));
newPt =  wEdge .* (no(newEdge(:,2),:) - no(newEdge(:,1),:)) + no(newEdge(:,1),:);

% newSegmentationLabel = wEdge .* (segmentationLabel(newEdge(:,2)) - segmentationLabel(newEdge(:,1))) + segmentationLabel(newEdge(:,1));
newSegmentationLabel = segmentationLabel(newEdge(:,2));

provaEdge = diff(segmentationLabel(newEdge),1,2);
mask = provaEdge ~= 0;


n = size(el,2);
ptMap=zeros(size(meshEdge,1),1);
ptMap(cutEdges)=1:size(cutEdges,1);

nEdgePerElement = n*(n-1)/2;
ptMap = reshape(ptMap,[],nEdgePerElement); % C^n_2

etag = sum(ptMap>0,2);

tricut = etag==3;
quadcut = etag==4;

tripatch=ptMap(tricut,:)';


tripatch=reshape(tripatch(tripatch > 0),3,[])';

quadpatch=ptMap(quadcut,:)';
quadpatch=reshape(quadpatch(quadpatch > 0),4,[])';


facedata=[tripatch(:,[1 2 3 3]); quadpatch(:,[1 2 4 3])];



facetedEdge = [facedata(:,[1,2]);facedata(:,[1,3]);facedata(:,[1,4]);
    facedata(:,[2,3]);facedata(:,[2,4]);facedata(:,[3,4])];


spam = find(mask);

idx = ismember(facetedEdge,spam);
mask2 = all(idx,2);
borders = facetedEdge(mask2,:);


x = [newPt(borders(:,1),1),newPt(borders(:,2),1)];
y = [newPt(borders(:,1),2),newPt(borders(:,2),2)];
z = [newPt(borders(:,1),3),newPt(borders(:,2),3)];

plot3(x(1:1000,:)',y(1:1000,:)',z(1:1000,:)')

a = axis;
h=patch('Vertices',newPt,...
    'Faces',facedata,...
    'FaceVertexCData',-newSegmentationLabel,...
    'facecolor','flat',...
    'EdgeColor','none');
hold on

plottone(newPt(mask,:))

view(3)
axis equal;

caxis( [-6 6]);
end
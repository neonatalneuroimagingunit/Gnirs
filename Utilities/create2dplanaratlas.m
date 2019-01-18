function DataBase = create2dplanaratlas(DataBase)

Atlas = NirsAtlas;

nPointAnyDirections = 10;
intraPoint = nPointAnyDirections*2;
mainDim = intraPoint+1;
gridsize = 21*(mainDim)-intraPoint;
x = 1:101;
y = 1:101;
[X,Y] = meshgrid(x,y);
face = delaunay(X,Y);

Atlas.name = '2D';
Atlas.date = datetime;

WhiteMatter.node = [X(:),Y(:),ones(size(X(:)))];
WhiteMatter.face = face;
Atlas.WhiteMatter = WhiteMatter;

GreyMatter.node = [X(:),Y(:),2.*ones(size(X(:)))];
GreyMatter.face = face;
Atlas.GreyMatter = GreyMatter;

Scalp.node = [X(:),Y(:),3.*ones(size(X(:)))];
Scalp.face = face;
Atlas.Scalp = Scalp;

x = (((1:gridsize)-1)./((gridsize-1)/100))+1;
y = (((1:gridsize)-1)./((gridsize-1)/100))+1;
[X,Y] = meshgrid(x,y);
Landmarks.coord = cat(3,X,Y,4.*ones(size(X)));
Landmarks.names = reshape(cellstr([num2str(X(:),'[%05.1f,'),num2str(Y(:),'%05.1f]')]),[gridsize,gridsize]);
Atlas.LandMarks = Landmarks;

Atlas.flagVoxel = false;
Atlas.flagHead = false;
Atlas.note = ['2d atlas in planar space (' num2str(gridsize) 'x' num2str(gridsize) ' grid)'];

DataBase = DataBase.add(Atlas);
DataBase.save;
end
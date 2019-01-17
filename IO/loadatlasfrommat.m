function loadatlasfrommat(GHandle)
%LOADATLASFROMMAT Summary of this function goes here
%   Detailed explanation goes here
pathFile = GHandle.TempWindow.location;
fileList = dir(pathFile);

Atlas = NirsAtlas;

fileIdx = contains({fileList.name}, 'GMSurfaceMesh');
filematIdx = contains({fileList.name}, '.mat');
fileIdx = and(fileIdx,filematIdx);
if any(fileIdx)
	GHandle.TempWindow.loadingBar.GrayMatter.loadingText = 'Loading Gray Matter...';
	temp = load(fullfile(fileList(fileIdx).folder,fileList(fileIdx).name));
	fieldName =  fieldnames(temp);
	Atlas.GreyMatter = temp.(fieldName{1});
	GHandle.TempWindow.loadingBar.GrayMatter.loadingPerc = 1;
	GHandle.TempWindow.loadingBar.GrayMatter.loadingText = ['Done!' newline];
end 
 
fileIdx = contains({fileList.name}, 'ScalpSurfaceMesh');
fileIdx = and(fileIdx,filematIdx);
if any(fileIdx)
    GHandle.TempWindow.loadingBar.GrayMatter.loadingText = 'Loading Scalp...';
	temp = load(fullfile(fileList(fileIdx).folder,fileList(fileIdx).name));
	fieldName =  fieldnames(temp);
	Atlas.Scalp = temp.(fieldName{1});
	GHandle.TempWindow.loadingBar.Scalp.loadingPerc = 1;
    GHandle.TempWindow.loadingBar.GrayMatter.loadingText = ['Done!' newline];
end
 
fileIdx = contains({fileList.name}, 'WMSurfaceMesh');
fileIdx = and(fileIdx,filematIdx);
if any(fileIdx)
    GHandle.TempWindow.loadingBar.GrayMatter.loadingText = 'Loading White Matter...';
	temp = load(fullfile(fileList(fileIdx).folder,fileList(fileIdx).name));
	fieldName =  fieldnames(temp);
	Atlas.WhiteMatter = temp.(fieldName{1});
	GHandle.TempWindow.loadingBar.WhiteMatter.loadingPerc = 1;
    GHandle.TempWindow.loadingBar.GrayMatter.loadingText = ['Done!' newline];
end
  
fileIdx = contains({fileList.name}, 'TissueMask');
fileIdx = and(fileIdx,filematIdx);
if any(fileIdx)
    GHandle.TempWindow.loadingBar.GrayMatter.loadingText = 'Loading Tissue Mask...';
	temp = load(fullfile(fileList(fileIdx).folder,fileList(fileIdx).name));
	fieldName =  fieldnames(temp);
	Atlas.flagVoxel = true;	
	GHandle.Temp.Voxel.Head = temp.(fieldName{1});
	GHandle.TempWindow.loadingBar.Voxel.loadingPerc = 1;
    GHandle.TempWindow.loadingBar.GrayMatter.loadingText = ['Done!' newline];
% 	if any(strcmp(structField, 'segmentation'))
% 		GHandle.Temp.Voxel.Segmentation = temp.segmentation;
% 	end
end
 
fileIdx = contains({fileList.name}, 'HeadVolumeMesh');
fileIdx = and(fileIdx,filematIdx);
if any(fileIdx)
	temp = load(fullfile(fileList(fileIdx).folder,fileList(fileIdx).name));
    GHandle.TempWindow.loadingBar.GrayMatter.loadingText = 'Loading Head Volume Mesh...';
	fieldName =  fieldnames(temp);
	Atlas.flagHead = true;
	GHandle.Temp.HeadAtlas = temp.(fieldName{1});
	GHandle.TempWindow.loadingBar.HeadVolume.loadingPerc = 1;
    GHandle.TempWindow.loadingBar.GrayMatter.loadingText = ['Done!' newline];
end

fileIdx = contains({fileList.name}, 'LandmarkPoints');
if any(fileIdx)
    GHandle.TempWindow.loadingBar.GrayMatter.loadingText = 'Generating Landmarks...';
	landmarkFile = fopen(fullfile(fileList(fileIdx).folder,fileList(fileIdx).name));
	tempPoint = fscanf(landmarkFile, '%*s %f %f %f',[3,4])';
	Nz = tempPoint(1,:);
	Iz = tempPoint(2,:);
	RPA = tempPoint(3,:);
	LPA = tempPoint(4,:);
	GHandle.TempWindow.loadingBar.LandMarks.loadingPerc = 0.1;
	Atlas.LandMarks = atlas105maker5(Atlas.Scalp.node,Nz,Iz,RPA,LPA,500,GHandle.TempWindow.loadingBar.LandMarks);
    GHandle.TempWindow.loadingBar.GrayMatter.loadingText = ['Done!' newline];
	fclose(landmarkFile);
end

GHandle.TempWindow.loadingBar.GrayMatter.loadingText = 'Saving to database...';
GHandle.CurrentDataSet.Atlas = Atlas;
end


function loadatlasfrommat(GHandle)
%LOADATLASFROMMAT Summary of this function goes here
%   Detailed explanation goes here
pathFile = GHandle.TempWindow.location;




fileList = dir(pathFile);

Atlas = NirsAtlas;

fileIdx = contains({fileList.name}, 'GMSurfaceMesh');
if any(fileIdx)
	GHandle.TempWindow.loadingBar.GrayMatter.loadingText = {'Loading Gray Matter....'};
	temp = load(fullfile(fileList(fileIdx).folder,fileList(fileIdx).name));
	fieldName =  fieldnames(temp);
	Atlas.GreyMatter = temp.(fieldName{1});
	GHandle.TempWindow.loadingBar.GrayMatter.loadingPerc = 1;
	GHandle.TempWindow.loadingBar.GrayMatter.loadingText = {'Gray Matter Loaded'};
end 
 

fileIdx = contains({fileList.name}, 'ScalpSurfaceMesh');
if any(fileIdx)
	temp = load(fullfile(fileList(fileIdx).folder,fileList(fileIdx).name));
	fieldName =  fieldnames(temp);
	Atlas.Scalp = temp.(fieldName{1});
	GHandle.TempWindow.loadingBar.Scalp.loadingPerc = 1;
end
 

fileIdx = contains({fileList.name}, 'WMSurfaceMesh');
if any(fileIdx)
	temp = load(fullfile(fileList(fileIdx).folder,fileList(fileIdx).name));
	fieldName =  fieldnames(temp);
	Atlas.WhiteMatter = temp.(fieldName{1});
	GHandle.TempWindow.loadingBar.WhiteMatter.loadingPerc = 1;
end
  


fileIdx = contains({fileList.name}, 'TissueMask');
if any(fileIdx)
	temp = load(fullfile(fileList(fileIdx).folder,fileList(fileIdx).name));
	fieldName =  fieldnames(temp);
	Atlas.flagVoxel = true;	
	GHandle.Temp.Voxel.Head = temp.(fieldName{1});
	GHandle.TempWindow.loadingBar.Voxel.loadingPerc = 1;
% 	if any(strcmp(structField, 'segmentation'))
% 		GHandle.Temp.Voxel.Segmentation = temp.segmentation;
% 	end
end
 

fileIdx = contains({fileList.name}, 'HeadVolumeMesh');
if any(fileIdx)
	temp = load(fullfile(fileList(fileIdx).folder,fileList(fileIdx).name));
	fieldName =  fieldnames(temp);
	Atlas.flagHead = true;
	GHandle.Temp.HeadAtlas = temp.(fieldName{1});
	GHandle.TempWindow.loadingBar.HeadVolume.loadingPerc = 1;
end
 

% Nz 	 -0.43 	 28.42 	 -14.19  
% Iz 	 -0.26 	 -61.33 	 -11.37  
% Ar 	 30.52 	 -15.31 	 -20.69  
% Al 	 -35.27 	 -15.01 	 -21.40  


fileIdx = contains({fileList.name}, 'LandmarkPoints');
if any(fileIdx)
	landmarkFile = fopen(fullfile(fileList(fileIdx).folder,fileList(fileIdx).name));
	tempPoint = fscanf(landmarkFile, '%*s %f %f %f',[3,4])';
	Nz = tempPoint(1,:);
	Iz = tempPoint(2,:);
	RPA = tempPoint(3,:);
	LPA = tempPoint(4,:);
	GHandle.TempWindow.loadingBar.LandMarks.loadingPerc = 0.1;
	%Atlas.LandMarks = atlas105maker(Atlas.Scalp.node,Nz,Iz,RPA,LPA,200,GHandle.TempWindow.loadingBar.LandMarks);
	Atlas.LandMarks = Copy_of_atlas105maker(Atlas.Scalp.node,Nz,Iz,RPA,LPA,200,GHandle.TempWindow.loadingBar.LandMarks);
	fclose(landmarkFile);
end
 

GHandle.CurrentDataSet.Atlas = Atlas;
end


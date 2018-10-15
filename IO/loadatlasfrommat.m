function loadatlasfrommat(GHandle)
%LOADATLASFROMMAT Summary of this function goes here
%   Detailed explanation goes here
pathFile = GHandle.TempWindow.location;

fileList = dir(pathFile);

Atlas = NirsAtlas;

fileIdx = contains({fileList.name}, 'GMSurfaceMesh');
if any(fileIdx)
	temp = load(fullfile(fileList(fileIdx).folder,fileList(fileIdx).name));
	fieldName =  fieldnames(temp);
	Atlas.GreyMatter = temp.(fieldName{1});
end 

fileIdx = contains({fileList.name}, 'ScalpSurfaceMesh');
if any(fileIdx)
	temp = load(fullfile(fileList(fileIdx).folder,fileList(fileIdx).name));
	fieldName =  fieldnames(temp);
	Atlas.Scalp = temp.(fieldName{1});
end

fileIdx = contains({fileList.name}, 'WMSurfaceMesh');
if any(fileIdx)
	temp = load(fullfile(fileList(fileIdx).folder,fileList(fileIdx).name));
	fieldName =  fieldnames(temp);
	Atlas.Scalp = temp.(fieldName{1});
end

%% 

if any(strcmp(structField, 'voxel'))
	Atlas.flagVoxel = true;	
	GHandle.Temp.Voxel.Head = temp.voxel;
	if any(strcmp(structField, 'optical_properties'))
		GHandle.Temp.Voxel.OpticalProprety = temp.optical_properties;
	end
	if any(strcmp(structField, 'segmentation'))
		GHandle.Temp.Voxel.Segmentation = temp.segmentation;
	end
end

if any(strcmp(structField, 'head'))
	Atlas.flagHead = true;
	GHandle.Temp.HeadAtlas = temp.head;
end





if any(strcmp(structField, 'landmarks'))
	temp.landmarks.coordinates = [[temp.landmarks.coordinates{:,1}]', [temp.landmarks.coordinates{:,2}]', [temp.landmarks.coordinates{:,3}]'];
	
	Atlas.LandMarks = atlas105maker(meshPoints,Nz,Iz,RPA,LPA,200);
end

GHandle.CurrentDataSet.Atlas = Atlas;
end


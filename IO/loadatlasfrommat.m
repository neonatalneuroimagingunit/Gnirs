function loadatlasfrommat(GHandle)
%LOADATLASFROMMAT Summary of this function goes here
%   Detailed explanation goes here
pathFile = GHandle.Temp.location;

temp = load(pathFile,'-mat');
structField = fields(temp);

Atlas = NirsAtlas;

if any(strcmp(structField, 'scalp'))
	Atlas.Scalp = temp.scalp;
end

if any(strcmp(structField, 'gm'))
	Atlas.GreyMatter = temp.gm;
end

if any(strcmp(structField, 'wm'))
	Atlas.WhiteMatter = temp.wm;
end

if any(strcmp(structField, 'landmarks'))
	temp.landmarks.coordinates = [[temp.landmarks.coordinates{:,1}]', [temp.landmarks.coordinates{:,2}]', [temp.landmarks.coordinates{:,3}]'];
	Atlas.LandMarks = temp.landmarks;
end

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

GHandle.CurrentDataSet.Atlas = Atlas;
end


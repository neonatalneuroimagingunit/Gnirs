function loadatlasfrommat(GHandle)
%LOADATLASFROMMAT Summary of this function goes here
%   Detailed explanation goes here
pathFile = GHandle.Temp.location;

temp = load(pathFile);
structField = fields(temp);

Atlas = NirsAtlas;

if any(strcmp(structField, 'gm'))
	Atlas.GreyMatter = temp.gm;
end

if any(strcmp(structField, 'wm'))
	Atlas.WhiteMatter = temp.wm;
end

if any(strcmp(structField, 'landmarks'))
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


end


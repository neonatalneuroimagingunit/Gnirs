function loadatlasfrommat(GHandle)
%LOADATLASFROMMAT Summary of this function goes here
%   Detailed explanation goes here
location = GHandle.Temp.location;

temp = load(location);
structField = fields(temp);

Atlas = NirsAtlas;

if any(contains(structField, 'voxel'))
	Atlas.flagVoxel = true;
end



end


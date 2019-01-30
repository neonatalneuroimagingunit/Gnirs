function VoxelAtlas = loadvoxel(DBAtlas)

if DBAtlas.flagVoxel
    temp = load(fullfile(DBAtlas.path, 'Voxel'),'Voxel');
    VoxelAtlas = temp.Voxel;
else
    warning('No Voxel found')
    VoxelAtlas = [];
end
end


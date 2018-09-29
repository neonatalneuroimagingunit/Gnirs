function [atlasId, DataBase] = newatlas(DataBase,varargin)
%Add an ATLAS to the database 
%DATABASE.newatlas('tag',atlas_tag)
%newatlas(DATABASE,'tag',atlas_tag) 
%
%

	% generate the new id
	atlasId = [DataBase.id , 'T' ,num2str(DataBase.nSAtlas,'%.3d')]; 
	DataBase.nSAtlas = DataBase.nSAtlas+1;
	
	posNewAtls = DataBase.nAtlas + 1;
	
	idx = find(contains(varargin,'tag','IgnoreCase',true), 1);
	
	if  ~isempty(idx)
		DataBase.Atlas(posNewAtls) = GDBAtlas('id',atlasId,...
											'tag',varargin{idx+1});
	else
		DataBase.Atlas(posNewAtls) = GDBAtlas('id',atlasId);
	end
	
end


function [atlasId, DataBase] = newatlas(DataBase,varargin)
	

	% generate the new id
	atlasId = [DataBase.id , 'T' ,num2str(DataBase.nSAtlas,'%.3d')]; 
	DataBase.nSAtlas = DataBase.nSAtlas+1;
	
	posNewAtls = DataBase.nAtlas + 1;
	
	if  (nargin == 1)
		DataBase.Atlas(posNewAtls) = GDBAtlas('id',atlasId,'tag',varargin{1});
	else
		DataBase.Atlas(posNewAtls) = GDBAtlas('id',atlasId);
	end
	
end


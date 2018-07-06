function [atlasId, DataBase] = newatlas(DataBase)
	

	% generate the new id
	atlasId = [DataBase.id , 'U' ,num2str(DataBase.nSAtlas,'%.3d')]; 
	DataBase.nSAtlas = DataBase.nSAtlas+1;
	
	posNewAtls = DataBase.nAtlas + 1;
	DataBase.Atlas(posNewAtls) = GDBAtlas(atlasId);
	
	DataBase.save;
	
	
	
end


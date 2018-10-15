function [DBAtlas, DataBase] = newatlas(DataBase,varargin)
%Add an ATLAS to the database 
%DATABASE.newatlas('tag',atlas_tag)
%newatlas(DATABASE,'tag',atlas_tag) 
%
%

	% generate the new id
	atlasPostFix = ['T' ,num2str(DataBase.nSAtlas,'%.3d')];
	atlasId = [DataBase.id , atlasPostFix];  
	DataBase.nSAtlas = DataBase.nSAtlas+1;
	
	posNewAtls = DataBase.nAtlas + 1;
	pathAtlas = fullfile(DataBase.path,'Atlas',atlasPostFix);
	mkdir(pathAtlas)	
	
	idx = find(contains(varargin,'tag','IgnoreCase',true), 1);

	if  ~isempty(idx)
		DBAtlas = GDBAtlas('id',atlasId,...
						'path',pathAtlas,...
						'tag',varargin{idx+1});
	else
		DBAtlas = GDBAtlas('id',atlasId,...
							'path',pathAtlas);
	end
	DataBase.Atlas(posNewAtls) = DBAtlas;

	
end


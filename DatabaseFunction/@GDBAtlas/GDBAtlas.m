classdef GDBAtlas
	

	properties (SetAccess = immutable)
		id
	end
		
	properties
		subjectId(1,:) char
		tag(1,:) char
		path(1,:) char
        
        flagVoxel (1,1) logical = false;
		flagHead (1,1) logical = false;
	end
	
	methods
 		Atlas = load(DBAtlas)
        HeadAtlas = loadhead(DBAtlas)
%		DBAtlas = modify(DBAtlas,NewAtlas)
 		DBAtlas = substitute(DBAtlas,Atlas)
	end
	methods (Static)
		postFix = id2atlaspostfix(id)
	end
	
	 methods
		function obj = GDBAtlas(varargin)
			for iArgIn = 1 : 2 : nargin
				switch varargin{iArgIn}
					case 'id'		
						obj.id = varargin{iArgIn + 1};
						
					case 'tag'
						obj.tag = varargin{iArgIn + 1};
						
					case 'path'
						obj.path = varargin{iArgIn + 1};
						
					otherwise
						warning('%s not a valid GDBMeasure field', varargin{iArgIn})			
				end
			end
		end
	end
end



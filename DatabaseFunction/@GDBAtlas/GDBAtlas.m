classdef GDBAtlas
	

	properties (SetAccess = immutable)
		id
	end
		
	properties
		subjectId
	end
	
	
	methods
		function obj = GDBAtlas(varargin)
			if (nargin >0 )
				obj.id = varargin{1};
			end
		end
	end
end



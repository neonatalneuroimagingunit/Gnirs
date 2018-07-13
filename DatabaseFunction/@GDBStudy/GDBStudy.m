classdef GDBStudy


	
	properties (SetAccess = immutable)
		id
	end
		
	properties
		phantomId
		path
		tag
	end
	
	
		%%	method
	methods
		 Study = load(DBStudy)
		 DBStudy = modify(DBStudy,NewStudy)
		 DBStudy = substitute(DBStudy,Study)
	end
	%% Static method
	
	methods

		function obj = GDBStudy(varargin)
			for iArgIn = 1 : 2 : nargin
				switch varargin{iArgIn}
					case 'id'		
						obj.id = varargin{iArgIn + 1};

					case 'tag'
						obj.tag = varargin{iArgIn + 1};
						
					case 'path'
						obj.path = varargin{iArgIn + 1};
						
					otherwise
						warning('%s not a valid GDBStudy field', varargin{iArgIn})			
				end
			end
		end
	end

end


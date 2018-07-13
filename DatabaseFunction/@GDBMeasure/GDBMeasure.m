classdef GDBMeasure


	properties (SetAccess = immutable)
		id
		studyId
	end
	properties		
		subjectId
		probeId
		
		tag
		path
	end
	
	methods
		
		function obj = GDBMeasure(varargin)
			for iArgIn = 1 : 2 : nargin
				switch varargin{iArgIn}
					case 'id'		
						obj.id = varargin{iArgIn + 1};
						
					case 'studyid'
						obj.studyId = varargin{iArgIn + 1};
						
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


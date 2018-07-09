classdef GDBStudy


	
	properties (SetAccess = immutable)
		id
	end
		
	properties
		Measure(:,1) GDBMeasure
		phantomId
		path
		tag
	end
	
	properties (SetAccess = private)
		nSMeasure(1,1) int16
	end
	
	properties (Dependent)
		nMeasure
	end
	
		%%	method
	methods
		 [measureId, Study] = newmeasure(Study)
		 Study = load(DBStudy)
		 DBStudy = modify(DBStudy,NewStudy)
		 DBStudy = substitute(DBStudy,Study)
	end
	%% Static method
	methods(Static)
		studyId = id2studyid(id)
		postFix = id2studypostfix(id)
	end	
	
	methods
		
		function nMeasure = get.nMeasure(obj)
			nMeasure = length(obj.Measure);
		end

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


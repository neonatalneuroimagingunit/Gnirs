classdef GDBStudy


	
	properties (SetAccess = immutable)
		id
	end
		
	properties
		Measure(:,1) GDBMeasure
		phantomId
		path
	end
	
	properties (SetAccess = private)
		nSMeasure(1,1) int16
	end
	
	properties (Dependent)
		nMeasure
	end
	
	methods
		
		function nMeasure = get.nMeasure(obj)
			nMeasure = length(obj.Measure);
		end

		function obj = GDBStudy(varargin)
			if (nargin >0 )
				obj.id = varargin{1};
				if (nargin >1 )
					obj.path = varargin{2};
				end
			end
		end
	end
	%%	method
	methods
		 [measureId, Study] = newmeasure(Study)
	end
	%% Static method
	methods(Static)
		studyId = id2studyid(id)
	end
end


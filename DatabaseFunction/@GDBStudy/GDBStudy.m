classdef GDBStudy


	
	properties (SetAccess = immutable)
		id
	end
		
	properties
		
		Measure(:,1) GDBMeasure
		
		phantomId
	end
	
	
	properties (Dependent)
		nMeasures
	end
	
	methods
		
		function nMeasures = get.nMeasures(obj)
			nMeasures = length(obj.Measures);
		end

		function obj = GDBStudy(varargin)
			if (nargin >0 )
				obj.id = varargin{1};
			end
		end
	end
end


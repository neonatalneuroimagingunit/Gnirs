classdef GDBProbe
	
	properties (SetAccess = immutable)
		id
	end
		
	properties
		Measures
	end
	
	
	properties (Dependent)
		nMeasures
	end
	
	methods
		
		function nMeasures = get.nMeasures(obj)
			nMeasures = size(obj.Measures, 1);
		end
	
		function obj = GDBProbe(varargin)
			if (nargin >0 )
				obj.id = varargin{1};
			end
		end
	end
end


classdef GDBSubject


	
	properties(SetAccess = immutable)
		id
		databaseId
		template(1,1) logical
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
		
		function obj = GDBSubject(varargin)
			if (nargin >0 )
				
				obj.id = varargin{1};
				if (nargin >1 )
					if (varargin{2} == 't')
						obj.template = true;
					else
						obj.template = false;
					end
				end
			end
		end
		
	end
end

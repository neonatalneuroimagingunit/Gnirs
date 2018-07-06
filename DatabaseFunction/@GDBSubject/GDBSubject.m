classdef GDBSubject


	
	properties
		id
		
		Measures
		
	end
	
	
	properties (Dependent)
		nMeasures
	end
	
	methods
		
		function nMeasures = get.nMeasures(obj)
			nMeasures = size(obj.Measures, 1);
		end

	end
end


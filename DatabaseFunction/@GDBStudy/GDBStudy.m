classdef GDBStudy


	
	properties
		id
		
		Measures(:,1) GDBMeasures
		
		dataBaseId
		
		phantomId
	end
	
	
	properties (Dependent)
		nMeasures
	end
	
	methods
		
		function nMeasures = get.nMeasures(obj)
			nMeasures = length(obj.Measures);
		end

	end
end


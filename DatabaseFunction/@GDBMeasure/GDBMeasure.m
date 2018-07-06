classdef GDBMeasure


	
	properties
		id
		
		Analysis(:,1) GDBAnalysis
		
		studyId
		
		probeId
		
		subjectId
	end
	
	
	properties (Dependent)
		nAnalysis
	end
	
	methods
		
		function nAnalysis = get.nAnalysis(obj)
			nAnalysis = length(obj.Analysis);
		end

	end
end


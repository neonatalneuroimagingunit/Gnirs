classdef GDBMeasure


	properties (SetAccess = immutable)
		id
		studyId
		
	end
	properties	
		Analysis(:,1) GDBAnalysis
		
		subjectId
		probeId
	end
	
	
	properties (Dependent)
		nAnalysis
	end
	
	methods
		
		function obj = GDBMeasure(varargin)
			if (nargin >0 )
				measureId =  varargin{1};
				studyId = id2studyid(measureId);
				
				obj.id = measureId;
				obj.studyId = studyId;
			end
		end
		
		
		function nAnalysis = get.nAnalysis(obj)
			nAnalysis = length(obj.Analysis);
		end

	end
end


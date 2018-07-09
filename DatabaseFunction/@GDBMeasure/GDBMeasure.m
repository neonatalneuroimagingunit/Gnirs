classdef GDBMeasure


	properties (SetAccess = immutable)
		id
		studyId
	end
	properties	
		Analysis(:,1) GDBAnalysis
		
		subjectId
		probeId
		
		tag
		path
	end
	
	properties (SetAccess = private)
		nSAnalysis(1,1) int16
	end
	
	properties (Dependent)
		nAnalysis
	end
	
	methods
		
		function obj = GDBMeasure(varargin)
			for iArgIn = 1 : 2 : nargin
				switch varargin{iArgIn}
					case 'id'		
						obj.id = varargin{iArgIn + 1};
						
						studyId = GDBStudy.id2studyid(obj.id);
						obj.studyId = studyId;
						
					case 'tag'
						obj.tag = varargin{iArgIn + 1};
						
					case 'path'
						obj.path = varargin{iArgIn + 1};
						
					otherwise
						warning('%s not a valid GDBMeasure field', varargin{iArgIn})			
				end
			end
		end

		
		function nAnalysis = get.nAnalysis(obj)
			nAnalysis = length(obj.Analysis);
		end
		
	end
	
	methods(Static)
		measureId = id2measureid(id)
	end
end


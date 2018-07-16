classdef GDBMeasure


	properties (SetAccess = immutable)
		id (1,:) char
		studyId (1,:) char
	end
	properties		
		subjectId (1,:) char
		probeId (1,:) char
		analysisId char
		
		tag (1,:) char
		path (1,:) char
	end
	
	properties (Dependent)
		nAnalysis(1,1) int32
	end
	
	methods
		Measure = load(DBMeasure)
		DBMeasure = modify(DBMeasure,NewMeasure)
		DBMeasure = substitute(DBMeasure,Measure)
	end
	methods (Static)
		postFix = id2postfix(id)
	end
	
	methods
		function nAnalysis = get.nAnalysis(obj)
			nAnalysis = size(obj.analysisId, 1);
		end
		
		function obj = GDBMeasure(varargin)
			for iArgIn = 1 : 2 : nargin
				switch varargin{iArgIn}
					case 'id'		
						obj.id = varargin{iArgIn + 1};
						
					case 'studyid'
						obj.studyId = varargin{iArgIn + 1};
						
					case 'tag'
						obj.tag = varargin{iArgIn + 1};
						
					case 'path'
						obj.path = varargin{iArgIn + 1};
						
					otherwise
						warning('%s not a valid GDBMeasure field', varargin{iArgIn})			
				end
			end
		end
	end
end


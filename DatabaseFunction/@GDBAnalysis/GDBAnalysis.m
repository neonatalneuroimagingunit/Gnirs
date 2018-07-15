classdef GDBAnalysis
	%GDBANALYSIS Summary of this class goes here
	%   Detailed explanation goes here
	
	properties (SetAccess = immutable)
		id
		measureId
	end
	properties
		tag
		path
	end
	
	methods
		Analysis = load(DBAnalysis)
		DBAnalysis = modify(DBAnalysis,NewAnalysis)
		DBAnalysis = substitute(DBAnalysis,Analysis)
	end
	methods (Static)
		postFix = id2studypostfix(id)
	end
	
	methods
		
		function obj = GDBAnalysis(varargin)
			for iArgIn = 1 : 2 : nargin
				switch varargin{iArgIn}
					case 'id'		
						obj.id = varargin{iArgIn + 1};
						
					case 'measureid'
						obj.measureId = GDBMeasure.id2measureid(obj.id);
						
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


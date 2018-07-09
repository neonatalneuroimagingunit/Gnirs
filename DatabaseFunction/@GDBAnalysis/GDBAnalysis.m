classdef GDBAnalysis
	%GDBANALYSIS Summary of this class goes here
	%   Detailed explanation goes here
	
	properties (SetAccess = immutable)
		id
		measureId
		studyId
	end
	properties
		tag
		path
	end
	
	methods
		
		function obj = GDBAnalysis(varargin)
			for iArgIn = 1 : 2 : nargin
				switch varargin{iArgIn}
					case 'id'		
						obj.id = varargin{iArgIn + 1};
						
						obj.measureId = GDBMeasure.id2measureid(obj.id);
						obj.studyId = GDBStudy.id2studyid(obj.id);
						
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


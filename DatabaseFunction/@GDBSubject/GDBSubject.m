classdef GDBSubject


	
	properties(SetAccess = immutable)
		id
		databaseId
		template(1,1) logical
	end
	
	properties
		tag
		MeasureId
		path
	end
	
	
	properties (Dependent)
		nMeasures
	end
	
	
	methods
		Subject = load(DBSubject)
		anonymize(DBSubject, field)
		substitute(DBSubject, Subject)
	end
	
	methods(Static)
			subjectpostfix = id2subjectpostfix(id);
	end

		
	
	methods
		
		function nMeasures = get.nMeasures(obj)
			nMeasures = size(obj.Measures, 1);
		end
		
		function obj = GDBSubject(varargin)
			for iArgIn = 1 : 2 : nargin
				switch varargin{iArgIn}
					case 'id'		
						obj.id = varargin{iArgIn + 1};
					case 'tag'
						obj.tag = varargin{iArgIn + 1};
					case 'path'
						obj.path = varargin{iArgIn + 1};
					case 'template'
						if varargin{iArgIn + 1}
							obj.template = true;
						else
							obj.template = false;
						end
					otherwise
						warning('%s not a valid GDBSubject field', varargin{iArgIn})			
				end
			end
		end
	end
	
end

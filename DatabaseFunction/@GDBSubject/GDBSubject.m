classdef GDBSubject


	
	properties(SetAccess = immutable)
		id(1,:) char
		template(1,1) logical
	end
	
	properties
		tag(1,:) char
		measureId char
		path(1,:) char
	end
	
	
	properties (Dependent)
		nMeasure (1,1) int16
	end
	
	
	methods
		Subject = load(DBSubject)
		DBSubject = anonymize(DBSubject, field)
		DBSubject = substitute(DBSubject, Subject)
		DBSubject = modifiy(DBSubject, Subject)
	end
	
	%% Static method
	methods (Static)
		postFix = id2postfix(id)
	end
	

		
	
	methods
		
		function nMeasure = get.nMeasure(obj)
			nMeasure = size(obj.measureId, 1);
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

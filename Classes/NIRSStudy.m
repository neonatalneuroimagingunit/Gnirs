classdef NIRSStudy
%     This class hold NIRS study data
% 	Propreties:
% 		name		| [string]



	properties
		name
		id
		date

		nMeasure
		nGroups
		nMeasurePersistent
		nGroupsPersistent

		measureLength
		analysisLength
		Measure
		Groups
		
		otherinfo
		note	
					
	end

	methods
		 
		 
		function obj = NIRSStudy(varargin)
			%initialize all possible field of the class
			%NIRSStudy
			% To load a data insert first the name of the field and than
			% the value.
			% ATTENTION there is no check in the data type

			if nargin ~= 0 
				if isa(varargin{1},'NIRSStudy')
					obj = varargin{1};
					varargin(1) = [];
				end
				for i = 1:2:(nargin-1)

					switch varargin{i}		
						case 'name'
							obj.name = varargin{i+1};

						case 'id'
							obj.id = varargin{i+1};

						case 'date'
							obj.date = varargin{i+1};

						case 'nMeasure'
							obj.nMeasure = varargin{i+1};

						case 'nGroups'
							obj.nGroups = varargin{i+1};
						
						case 'nMeasurePersistent'
							obj.nMeasurePersistent = varargin{i+1};

						case 'nGroupsPersistent'
							obj.nGroupsPersistent = varargin{i+1};			
						
						case 'measureLength'
							obj.measureLength = varargin{i+1};

						case 'analysisLength'
							obj.analysisLength = varargin{i+1};

						case 'Measure'
							obj.Measure = varargin{i+1};
						
						case 'Groups'
							obj.Groups = varargin{i+1};

						case 'otherinfo'
							obj.otherinfo = varargin{i+1};

						case 'note'
							obj.note = varargin{i+1};
					end
				end
			end
		end
	end

end

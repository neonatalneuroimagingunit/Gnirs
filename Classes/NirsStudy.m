classdef NirsStudy
%     This class hold NIRS study data
% 	Propreties:
% 		name		| [string]
%ATTENZIONE DECOMMENTARE NIRSGROUP E MEASURE APPENA SARANNO DEFINITE
%E AGGIUNGERE LE VARIABILI DIPENDENTI


	properties
		id(1,:) char
		name(1,:) char
		date(1,1) datetime 
		SubjectTemplate(1,1) NirsSubject


		nMeasurePersistent(1,1) uint16 
		nGroupsPersistent(1,1) uint16 

		
		dateFirstMeasure(1,1) datetime = NaT
		dateLastMeasure(1,1) datetime = NaT
		
		dateFirstAnalysis(1,1) datetime = NaT
		dateLastAnalysis(1,1) datetime = NaT
		
 		Measure(1,:) %NirsMeasure
 		Groups(1,:) %NirsGroup
		
		note(1,:) char				
	end
	
	properties (Dependent)
	   	nMeasure(1,1) uint16
		nGroups(1,1) uint16 
		
		measureLength(1,1) duration
		analysisLength(1,1) duration
	end
	
	
	methods
		function nMeasure = get.nMeasure(obj)
			nMeasure = length(obj.Measure);
		end
		
		function nGroups = get.nGroups(obj)
			nGroups = length(obj.Groups);
		end	
		
		function measureLength = get.measureLength(obj)
			measureLength = obj.dateLastMeasure - obj.dateFirstMeasure;
		end
		
		function analysisLength = get.analysisLength(obj)
			analysisLength = obj.dateLastAnalysis - obj.dateFirstAnalysis;
		end
		
		function obj = NirsStudy(varargin)
			%initialize all possible field of the class
			%NIRSStudy
			% To load a data insert first the name of the field and than
			% the value.
			% ATTENTION there is no check in the data type

			if nargin ~= 0 
				if isa(varargin{1},'NirsStudy')
					obj = varargin{1};
					varargin(1) = [];
				end
				for i = 1:2:(nargin-1)

					switch varargin{i}		

						case 'id'
							obj.id = varargin{i+1};						
						
						case 'name'
							obj.name = varargin{i+1};

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
							
						case 'dateFistMeasure'
							obj.measureLength = varargin{i+1};
							
						case 'dateLastMeasure'
							obj.measureLength = varargin{i+1};

						case 'analysisLength'
							obj.analysisLength = varargin{i+1};

						case 'Measure'
							obj.Measure = varargin{i+1};
						
						case 'Groups'
							obj.Groups = varargin{i+1};

						case 'note'
							obj.note = varargin{i+1};
							
						otherwise
							warning('field %s is not a valif field', varargin{i});
					end
				end
			end
		end
	end

end


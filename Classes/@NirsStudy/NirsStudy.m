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
	
		dateFirstMeasure(1,1) datetime = NaT
		dateLastMeasure(1,1) datetime = NaT
		
		dateFirstAnalysis(1,1) datetime = NaT
		dateLastAnalysis(1,1) datetime = NaT
		
		note(1,:) char				
	end
	
	properties (Dependent)
		measureLength(1,1) duration
		analysisLength(1,1) duration
	end
	
	
	methods

		
	end
	
	methods
		
		
		function measureLength = get.measureLength(obj)
			measureLength = obj.dateLastMeasure - obj.dateFirstMeasure;
		end
		
		function analysisLength = get.analysisLength(obj)
			analysisLength = obj.dateLastAnalysis - obj.dateFirstAnalysis;
		end
		
		function obj = NirsStudy(varargin)

			if nargin ~= 0 
				if isa(varargin{1},'NirsStudy')
					obj = varargin{1};
					varargin(1) = [];
				end
				for i = 1:2:(nargin-1)

					switch lower(varargin{i})		

						case 'id'
							obj.id = varargin{i+1};						
						
						case 'name'
							obj.name = varargin{i+1};

						case 'date'
							obj.date = varargin{i+1};
							
						case 'datefirstmeasure'
							obj.dateFirstMeasure = varargin{i+1};
							
						case 'datelastmeasure'
							obj.dateLastMeasure = varargin{i+1};
							
						case 'datelastanalysis'
							obj.dateLastAnalysis = varargin{i+1};
							
						case 'datefirstanalysis'
							obj.dateFirstAnalysis = varargin{i+1};

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


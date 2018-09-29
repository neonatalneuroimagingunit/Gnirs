classdef NirsAnalysis
	%NIRSANALYSIS Summary of this class goes here
	%   Detailed explanation goes here
	
	properties
		id(1,:) char
		
		measureId(1,:) char
		
		date(1,1) datetime = NaT;
		
		analysis
		
		SimplyData
		
		note(1,:) char
	end
	
methods
	Handle = guidisp(Analysis, PannelHandle , editableField)
end

methods
		 
		 
		function obj = NirsAnalysis(varargin)
			%initialize all possible field of the class
			%NirsSubject
			% To load a data insert first the name of the field and than
			% the value.

			if nargin ~= 0 
				if isa(varargin{1},'NirsAnalysis')
					obj = varargin{1};
					varargin(1) = [];
				end
				for i = 1:2:(nargin-1)

					switch lower(varargin{i})		

						case 'id'
							obj.id = varargin{i+1};
													
						case 'measureid'
							obj.measureId = varargin{i+1};
							
						case 'date'
							obj.date = varargin{i+1};

						case 'analysis'
							obj.analysis = varargin{i+1};

						case 'note'
							obj.note = varargin{i+1};
							
						case 'simplydata'
							obj.SimplyData = varargin{i+1};
							
						otherwise
							warning('the %s field is not a valid field',varargin{i});
					end
				end
			end
		end
	 end
end


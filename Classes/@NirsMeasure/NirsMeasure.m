 classdef NirsMeasure
%     This class hold Nirs measure data
% 	Propreties:

% 		
				
    
    properties
		
		id(1,:) char
		
		date(1,1) datetime = NaT;
	
		timeLength(1,1) duration
		
		updateRate(1,1) double

		videoFlag(1,1) logical
		
		Info 

		note(1,:) char
	end
	
    methods

		
	end
	
    methods

		function obj = NirsMeasure(varargin)
			%loadNIRS initialize all possible field of the class NIRSdata
			% To load a data insert first the name of the field and than
			% the value.

			if nargin ~= 0 
				if isa(varargin{1},'NirsMeasure')
					obj = varargin{1};
					varargin(1) = [];
				end
				for i = 1:2:(nargin-1)

					switch lower(varargin{i})		
						case 'id'
							obj.id = varargin{i+1};

						case 'date'
							obj.date = varargin{i+1};

						case 'timelength'
							obj.timeLength = varargin{i+1};
							
						case 'updaterate'
							obj.updateRate = varargin{i+1};

						case 'videoflag '
							obj.videoFlag  = varargin{i+1};

						case 'info'
							obj.Info = varargin{i+1};
						
						case 'note'
							obj.note = varargin{i+1};

						otherwise 
							warning('data not loaded')
										
					end
				end
			end
		end
	end
 end

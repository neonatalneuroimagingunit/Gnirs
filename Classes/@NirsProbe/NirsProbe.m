classdef NirsProbe
	%NIRSANALYSIS Summary of this class goes here
	%   Detailed explanation goes here
	
	properties
		id(1,:) char
		
		name(1,:) char
		
		source(:,2) double
		
		detector(:,2) double
		
		channel(:,2) int32
		
		distance(:,1) double
		
		note(1,:) char
	end
	
methods
	
end
methods
		 
		 
		function obj = NirsProbe(varargin)
			%initialize all possible field of the class
			%NirsSubject
			% To load a data insert first the name of the field and than
			% the value.

			if nargin ~= 0 
				if isa(varargin{1},'NirsProbe')
					obj = varargin{1};
					varargin(1) = [];
				end
				for i = 1:2:(nargin-1)

					switch lower(varargin{i})		

						case 'id'
							obj.id = varargin{i+1};
							
						case 'name'
							obj.name = varargin{i+1};
													
						case 'source'
							obj.source = varargin{i+1};
							
						case 'detector'
							obj.detector = varargin{i+1};

						case 'channel'
							obj.channel = varargin{i+1};

						case 'note'
							obj.note = varargin{i+1};
							
						case 'distance'
							obj.distance = varargin{i+1};
							
						otherwise
							warning('the %s field is not a valid field',varargin{i});
					end
				end
			end
		end
	 end
end


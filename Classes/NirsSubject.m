 classdef NirsSubject
%     This class hold NIRS Subject
% 	Propreties:
% 		name	|	[string]
%		sname	|	surname [string]
%  		bdate	|	birthday [datetime]
% 		ID		|	univocal identifier of the subject
% 		note	|	[string] 
% 		
			
    
    properties
		id(1,:) char
		name(1,:) char
		surName(1,:) char
		birthDay(1,1) datetime
		Info(1,1) struct 
		measureId(:,1) cell
		note(1,:) char
		template(1,1) logical
	end
	
	
	 methods
		 
		 
		function obj = NirsSubject(varargin)
			%initialize all possible field of the class
			%NirsSubject
			% To load a data insert first the name of the field and than
			% the value.

			if nargin ~= 0 
				if isa(varargin{1},'NirsSubject')
					obj = varargin{1};
					varargin(1) = [];
				end
				for i = 1:2:(nargin-1)

					switch lower(varargin{i})		
						case 'name'
							obj.name = varargin{i+1};

						case 'surname'
							obj.surName = varargin{i+1};

						case 'birthday'
							obj.birthDay = varargin{i+1};

						case 'id'
							obj.id = varargin{i+1};
						
						case 'info'
							obj.Info = varargin{i+1};

						case 'note'
							obj.note = varargin{i+1};
							
						case 'template'
							obj.template = varargin{i+1};
						otherwise
							warning('the %s field is not a valid field',varargin{i});
					end
				end
			end
		end
	 end
 end
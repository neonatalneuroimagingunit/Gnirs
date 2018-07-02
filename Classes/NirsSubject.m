 classdef NirsSubject
%     This class hold NIRS Subject
% 	Propreties:
% 		name	|	[string]
%		sname	|	surname [string]
%  		bdate	|	birthday [datetime]
% 		age		|	age in days [int]
% 		ID		|	univocal identifier of the subject
%		apgar1	|	apgar resuts at 1 minute from birth
%		apgar5	|	apgar resuts at 1 minute from birth
% 		note	|	[string] 
% 		
			
    
    properties
		id(1,:) char
		name(1,:) char
		surName(1,:) char
		birthDate(1,1) datetime
		Info(1,1) struct 
		measureId(:,1) cell
		note(1,:) char
		template(1,1) logical
	end
	
	
	 methods
		 
		 
		function obj = NIRSSubject(varargin)
			%initialize all possible field of the class
			%NirsSubject
			% To load a data insert first the name of the field and than
			% the value.

			if nargin ~= 0 
				if isa(varargin{1},'NIRSSubject')
					obj = varargin{1};
					varargin(1) = [];
				end
				for i = 1:2:(nargin-1)

					switch varargin{i}		
						case 'name'
							obj.name = varargin{i+1};

						case 'surName'
							obj.sname = varargin{i+1};

						case 'birthDate'
							obj.bdate = varargin{i+1};

						case 'id'
							obj.ID = varargin{i+1};
						
						case 'Info'
							obj.Info = varargin{i+1};

						case 'note'
							obj.note = varargin{i+1};
							
						case 'template'
							obj.template = varargin{i+1};
					end
				end
			end
		end
	 end
 end
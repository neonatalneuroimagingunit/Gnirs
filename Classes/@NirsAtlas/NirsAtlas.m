classdef NirsAtlas
%     This class hold NIRS Atlas data
% 	Propreties:
% 		name		| [string]



	properties
		id(1,:) char
		tag(1,:) char
		date(1,1) datetime 
	
		WhiteMatter struct
		GreyMatter struct
		Scalp  struct
		
		LandMarks struct
		
		flagVoxel logical = false;
		flagHead logical = false;
		
		note (1,:) char
	end
	
	methods
		Handle = guidisp(Atlas, PannelHandle , editableField)
	end
	
	methods

		
		function obj = NirsStudy(varargin)

			if nargin ~= 0 
				if isa(varargin{1},'NirsAtlas')
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
							
						case 'greymatter'
							obj.GreyMatter = varargin{i+1};
							
						case 'scalp'
							obj.Scalp = varargin{i+1};
							
						case 'flagvoxel'
							obj.flagVoxel = varargin{i+1};
							
						case 'flaghead'
							obj.flagHead = varargin{i+1};

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


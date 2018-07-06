classdef GDataBase


	
	properties (SetAccess = immutable)
		id
	end
	
	properties (SetAccess = private)
		Probe(:,1) GDBProbe
		
		Subject(:,1) GDBSubject
		
		Atlas(:,1) GDBAtlas
		
		Study(:,1) GDBStudy
		
		path
		
	end
	
	
	properties (Dependent)
		nProbe
		
		nSubject
		
		nAtlas
		
		nStudy
	end
	
	methods
		
		function nProbe = get.nProbe(obj)
			nProbe = length(obj.Probe);
		end
		
		function nSubject = get.nSubject(obj)
			nSubject = length(obj.Subject);
		end
		
		function nAtlas = get.nAtlas(obj)
			nAtlas = length(obj.Atlas);
		end
		
		function nStudy = get.nStudy(obj)
			nStudy = length(obj.Study);
		end

		
		function obj = GDataBase(varargin)
			nId = randi(1000000)-1; %creo un  numero compreso tra 0 e 999999
			obj.id = ['D', num2str(nId,'%.6d')]; %create the ID
			
			if (nargin == 1)
				obj.path = varargin{1};
			end
		end
		
	end
end



classdef GDataBase


	
	properties (SetAccess = immutable)
		id
	end
	
	properties (SetAccess = private)
		Probe(:,1) GDBProbe
		nSProbe(1,1) int16
		
		Subject(:,1) GDBSubject
		nSSubject(1,1) int16
		
		Atlas(:,1) GDBAtlas
		nSAtlas(1,1) int16
		
		Study(:,1) GDBStudy
		nSStudy(1,1) int16
		
		path
		
	end
	
	
	properties (Dependent)
		nProbe
		
		nSubject
		
		nAtlas
		
		nStudy
	end
	
	methods
	%% methods for the dependent propr
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

%% costructor		
		function obj = GDataBase(varargin)
			nId = randi(1000000)-1; %creo un  numero compreso tra 0 e 999999
			obj.id = ['D', num2str(nId,'%.6d')]; %create the ID
			
			if (nargin == 1)
				obj.path = varargin{1};
			end
		end
		
	end
%%	method
	methods
	save(DataBase)
	[subjectId, DataBase] = newsubject(DataBase)
	[probeId, DataBase] = newprobe(DataBase)
	[atlasId, DataBase] = newatlas(DataBase)
	[studyId, DataBase] = newstudy(DataBase)
	end
%% static method
	methods(Static)
		DataBase = create(pathDataBase, pathGnirs)
		DataBase = load(pathDataBase)
	end
end



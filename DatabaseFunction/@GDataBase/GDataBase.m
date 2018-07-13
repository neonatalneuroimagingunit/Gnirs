classdef GDataBase


	
	properties (SetAccess = immutable)
		id
	end
	properties
		
		Probe(:,1) GDBProbe
		Subject(:,1) GDBSubject
		Atlas(:,1) GDBAtlas	
		Study(:,1) GDBStudy
		Measure(:,1) GDBMeasure
		Analysis(:,1) GDBAnalysis
		
	end
	
	properties (SetAccess = private)
		
		nSProbe(1,1) int16
		nSSubject(1,1) int16
		nSAtlas(1,1) int16
		nSStudy(1,1) int16
		nSMeasure(1,1) int32
		nSAnalysis(1,1) int32
		
		
		path
		
	end
	
	
	properties (Dependent)
		nProbe(1,1) int16
		nSubject(1,1) int16
		nAtlas(1,1) int16
		nStudy (1,1) int16
		nMeasure(1,1) int32
		nAnalysis(1,1) int32
	end
	
	%%	method
	methods
	save(DataBase)
	Find = findid(DataBase, id)
	[subjecttemplateId, DataBase] = newsubjecttemplate(DataBase, varargin)
	[subjectId, DataBase] = newsubject(DataBase, varargin)
	[probeId, DataBase] = newprobe(DataBase, varargin)
	[atlasId, DataBase] = newatlas(DataBase, varargin)
	[studyId, DataBase] = newstudy(DataBase, varargin)
	[analysisId, DataBase] = newanalysis(DataBase, varargin)
	[measureId, DataBase] = newmeasure(DataBase, varargin)
	end
	
%% static method
	methods(Static)
		DataBase = create(pathDataBase, pathGnirs)
		DataBase = load(pathDataBase)
		idDatabase = id2databaseid(id)
	end
	
	%% methods for the dependent propr
	methods
		function nMeasure = get.nMeasure(obj)
			nMeasure = length(obj.Measure);
		end
		
		function nAnalysis = get.nAnalysis(obj)
			nAnalysis = length(obj.Analysis);
		end
		
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
end



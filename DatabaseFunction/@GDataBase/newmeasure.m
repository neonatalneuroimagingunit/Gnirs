function [DBMeasure, DataBase] = newmeasure(DataBase, studyId, varargin)
	
	[Study, idxStudy] = DataBase.findid(studyId);
	if ~isempty(Study)
		% generate the new id
 
		measurePostFix = ['M' ,num2str(DataBase.nSMeasure,'%.6d')];
		measureId = [DataBase.id , measurePostFix ]; 
		DataBase.nSMeasure = DataBase.nSMeasure+1;

		posNewMeas = DataBase.nMeasure + 1;


		%create the new directory
		pathMeasure = fullfile([Study.path,'Measure'],measurePostFix);
		pathMeasureAnalysis = [pathMeasure,'Analysis'];
		mkdir(pathMeasureAnalysis)

		idxArg = find(contains(varargin,'tag','IgnoreCase',true), 1);
		if  ~isempty(idxArg)
			DBMeasure = GDBMeasure('id',measureId,...
									'path',pathMeasure,...
									'studyid',Study.id,...
									'tag',varargin{idxArg +1 });
		else
			DBMeasure = GDBMeasure('id',measureId,...
									'path',pathMeasure,...
									'studyid',Study.id);
        end
        probeIdx = find(contains(varargin,'probeId','IgnoreCase',true), 1);
        if probeIdx
            DBMeasure.probeId = varargin{probeIdx+1};
        end
		idxArg = find(contains(varargin,'subjectid','IgnoreCase',true), 1);
		
		if  ~isempty(idxArg)
			DBMeasure.subjectId = varargin{idxArg+1};
			
			idxSubject = contains({DataBase.Subject(:).id}, DBMeasure.subjectId);
			idxMeasure = DataBase.Subject(idxSubject).nMeasure + 1;
			DataBase.Subject(idxSubject).measureId(idxMeasure,:) = measureId;
		end
		
		DataBase.Measure(posNewMeas) = DBMeasure;
		posNewMeasure = Study.nMeasure + 1;
		DataBase.Study(idxStudy).measureId(posNewMeasure,:)	= measureId;

		
	else
		error('Study not present in the database')
	end
	
end


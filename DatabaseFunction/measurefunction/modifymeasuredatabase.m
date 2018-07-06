function DataBase = modifymeasuredatabase(NewMeasure,DataBase)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes her

	% if is a link load it
	if ischar(DataBase)
		DataBase = loadNIRSdb(DataBase);
	end

	measureId = NewMeasure.id;
	
	studyId = id2studyid(measureId);
	NewStudy = findstudy('id', studyId, DataBase);
	
	[OldMeasure, index] = findmeasure('id', measureId, DataBase);
	
	Measure = NewMeasure;
	%value cannot be change
	Measure.studyId = OldMeasure.studyId;
	
	% assign all nonspecify value to the old value
	if isempty(NewMeasure.subjectId)
		Measure.subjectId = OldMeasure.subjectId;
	else
		OldSubject = findsubject(OldMeasure.subjectId);
		NewSubject = findsubject(NewMeasure.subjectId);
		
		OldSubject.measureId(OldSubject.measureId{:} == measureId) = [];
		NewSubject.measureId = {NewSubject.measureId{:} ;measureId};
		
		modifysubjectdatabase(OldSubject,DataBase);
		modifysubjectdatabase(NewSubject,DataBase);
	end
	
	
	if isempty(NewMeasure.probeId)
		Measure.probeId = OldMeasure.probeId;
% 	else
% 		OldProbe = findprobe(OldMeasure.subjectId);
% 		NewProbe = findprobe(NewMeasure.subjectId);
% 		
% 		OldProbe.measureId(OldProbe.measureId{:} == measureId) = [];
% 		NewProbe.measureId = {NewProbe.measureId{:} ;measureId};
% 		
% 		modifyprobedatabase(OldProbe,DataBase);
% 		modifyprobedatabase(NewProbe,DataBase);
	end
	
	
	if isempty(NewMeasure.Analysis)
		Measure.Analysis = OldMeasure.Analysis;
	end
	
	if isempty(NewMeasure.Marker)
		Measure.Marker = OldMeasure.Marker;
	end
	
	if (NewMeasure.date == NaT)
		Measure.date = OldMeasure.date;
	end
	
	if (NewMeasure.timeLength == 0)
		Measure.timeLength = OldMeasure.timeLength;
	end
	
	if (NewMeasure.updateRate == 0)
		Measure.updateRate = OldMeasure.updateRate;
	end
	
	if isempty(NewMeasure.note)
		Measure.note = OldMeasure.note;
	end

	if isempty(NewMeasure.Info)
		Measure.Info = OldMeasure.Info;
	else
		% check all the field of the new and assign to the old
		oldFieldNames = fieldnames(OldMeasure.Info);
		newFieldNames = fieldnames(NewMeasure.Info);

		oldFieldNames2Save = oldFieldNames(~ismember(oldFieldNames , newFieldNames));
		for iField = 1 : length(oldFieldNames2Save)
			Measure.Info.(oldFieldNames2Save{iField}) = OldMeasure.Info(oldFieldNames2Save{iField});
		end
	end
	
	NewStudy.Measure(index) = Measure;
	
	DataBase = modifystudydatabase(NewStudy,DataBase);

end


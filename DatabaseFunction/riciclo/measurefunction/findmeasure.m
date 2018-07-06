function [MeasureList, positiveMatch] = findmeasure(field, value ,DataBase)
%FINDMeasure find ameasure in the database
	%if the databse was a link load it
	if ischar(DataBase)
		DataBase = loadNIRSdb(DataBase);
	end
	% load all the database study
	if ischar(field)
		field = {field};
	end
	if ischar(value)
		value = {value};
	end
	
	
	%search for a specify measure
	idxId = strcmpi(field,'id');
	if any(idxId)
		measureId = value{idxId};
		studyId = id2studyid(measureId);
		Study = findstudy('id',studyId, DataBase);
		
		if ~isempty(Study)	
			positiveMatch = strcmpi({Study.Measure(:).id},measureId);
			MeasureList = Study.Measure(positiveMatch);
		else 
			warning('no measure found');
		end
	%search in a study
	else
		idxStudyId = strcmpi(field,'studyid');
		if any(idxStudyId)

			studyId = value{idxStudyId};
			value(idxStudyId) = [];
			field(idxStudyId) = [];
			Study = findstudy('id',studyId, DataBase);
			
			
			positiveMatch = boolean(ones(1,Study.nMeasure));

			for iMeasure = 1 : Study.nMeasure
				CurrentMeasure = Study.Measure(iMeasure);
					for iField = 1 : length(field)
						%search all the field lower case 
						switch lower(field{iField}) 
							% if the value is not present delete the subject from
							% array
							case 'subjectid'
								if isempty(regexp(CurrentMeasure.subjectId,value{iField},'once'))
									positiveMatch(iMeasure) = 0; 
								end
								
							case 'probeid'
								if isempty(regexp(CurrentMeasure.probeId,value{iField},'once'))
									positiveMatch(iMeasure) = 0; 
								end

							case 'date'
								if ~(CurrentMeasure.date == value{iField})
									positiveMatch(iMeasure) = 0; 
								end
								
							case 'timelength'
								if ~(CurrentMeasure.timeLength == value{iField})
									positiveMatch(iMeasure) = 0; 
								end
								
								
							case 'updaterate'
								if ~(CurrentMeasure.updateRate == value{iField})
									positiveMatch(iMeasure) = 0; 
								end
								
							case 'videoflag'
								if ~(CurrentMeasure.videoFlag == value{iField})
									positiveMatch(iMeasure) = 0; 
								end

							case 'note'
								if isempty(regexp(CurrentMeasure.note,value{iField},'once'))
									positiveMatch(iMeasure) = 0; 
								end	
							otherwise
								if isfield(CurrentMeasure.Info, field{iField})
									if ~(CurrentMeasure.Info.(field{iField}) == value{iField})
											positiveMatch(iMeasure) = 0; 
									end
								else 
									warning('field %s is not present it will not be used in the search', field{iField});

								end
						end
					end
			end
			
			MeasureList = Study.Measure(positiveMatch);
			
		else
			error('study id or measure id have to be specify')
		end
	end

end

function DBMeasure = modify(DBMeasure,NewMeasure)
%ADDMODIFYSUBJECT add or modify a subject present in the database


	if (strcmp(DBMeasure.id,NewMeasure.id) || isempty(NewMeasure.id))
	
		OldMeasure = DBMeasure.load;

		Measure = NewMeasure;
		if isempty(NewMeasure.id)
			Measure.id = OldMeasure.id;
		end
	
		if isempty(NewMeasure.date)
			Measure.date = OldMeasure.date;
		end

		if isempty(NewMeasure.timeLength)
			Measure.timeLength = OldMeasure.timeLength;
		end

		if isempty(NewMeasure.updateRate)
			Measure.updateRate = OldMeasure.updateRate;
		end
		
		if isempty(NewMeasure.videoFlag)
			Measure.videoFlag = OldMeasure.videoFlag;
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
		
		save(DBMeasure.path,'Measure');
		
	else 
		error('id not match')
	end
end

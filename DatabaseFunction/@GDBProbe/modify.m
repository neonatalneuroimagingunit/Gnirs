function DBProbe = modify(DBProbe,NewProbe)

%ADDMODIFYSUBJECT add or modify a subject present in the database


	if (strcmp(DBProbe.id,NewProbe.id) || isempty(NewProbe.id))
	
		OldProbe = DBProbe.load;

		Probe = NewProbe;
		if isempty(NewProbe.id)
			Probe.id = OldProbe.id;
		end
	
		if isempty(NewProbe.source)
			Probe.source = OldProbe.source;
		end

		if isempty(NewProbe.detector)
			Probe.detector = OldProbe.detector;
		end

		if isempty(NewProbe.channel)
			Probe.channel = OldProbe.channel;
		end
		
		if isempty(NewProbe.distance)
			Probe.distance = OldProbe.distance;
		end
		
		if isempty(NewProbe.note)
			Probe.note = OldProbe.note;
		end

		save(DBProbe.path,'Probe');
		
	else 
		error('id not match')
	end
end

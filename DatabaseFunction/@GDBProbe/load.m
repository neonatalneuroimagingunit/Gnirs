function Probe = load(DBProbe)
	
	temp = load(DBProbe.path,'Probe');
	Probe = temp.Probe;
end


function Measure = load(DBMeasure)
	
	temp = load(DBMeasure.path,'Study');
	Measure = temp.Study;
end


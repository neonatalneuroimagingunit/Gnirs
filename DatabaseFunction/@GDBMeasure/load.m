function Measure = load(DBMeasure)
	
	temp = load(DBMeasure.path,'Measure');
	Measure = temp.Measure;
end


function Data = loaddata(DBAnalysis)
	
	temp = load(DBAnalysis.path,'Data');
	Data = temp.Data;
end


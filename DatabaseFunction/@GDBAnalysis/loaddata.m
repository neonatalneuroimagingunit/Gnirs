function Data = loaddata(DBAnalysis)
	
	temp = load(DBAnalysis.path,'Analysis');
	Data = temp.Data;
end


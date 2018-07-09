
DataBase = GDataBase.load('/home/pagno/Desktop/aaa/GDataBase');

field = {'tag','name','cane','bello','sicuro'};
value = {'ddd','gino','si',5,false};

NirsSubject.addtemplate(field, value, DataBase)

DataBase.Subject(10).anonymize(field, DataBase);

%GDataBase.create('/home/pagno/Desktop/aaa','/home/pagno/Desktop/aaa');
DataBase = GDataBase.load('/home/pagno/Desktop/aaa/GDataBase');

% 
% info.bello = false;
% info.bellezza = 4;
% Subject = NirsSubject('name','fili', 'info',info);

% %Subject.add(DataBase);
% field = {'name'};
% 
% DataBase.Subject(2).anonymize(field)


Study = NirsStudy('name','fili', 'note','info');
Study.add(DataBase)
% %Subject.add(DataBase);
% field = {'name'};

DataBase.Subject(2).anonymize(field)
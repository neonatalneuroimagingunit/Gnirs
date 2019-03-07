function DBStudy = modify(DBStudy, field, value)
if ~iscell(field)
    field = {field};
end

if ~iscell(value)
    value = {value};
end

Study = DBStudy.load;
for iField = 1:1:length(field)
    Study.(field{iField}) = value{iField};
end
save(DBStudy.path,'Study');
end

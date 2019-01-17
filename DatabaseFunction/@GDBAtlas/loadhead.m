function HeadAtlas = loadhead(DBAtlas)

if DBAtlas.flagHead
    temp = load(fullfile(DBAtlas.path, 'HeadAtlas'),'HeadAtlas');
    HeadAtlas = temp.HeadAtlas;
else
    warning('No head found')
    HeadAtlas = [];
end
end


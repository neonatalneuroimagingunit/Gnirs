function equalIdx = eq(Vector,Obj)
idArray =  {Vector(:).id};
equalIdx = strcmp(idArray,Obj.id)';
end


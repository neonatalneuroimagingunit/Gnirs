function [MainHandle] = populatedisplay(id, DataBase, MainHandle)
	
	
	[find, nDisp] = finddependence(DataBase, id);


	nRow(2) = fix(nDisp / 2);
	nRow(1) = nDisp - nRow(2);
	nCol = 1 + (nRow(2) > 0);
	
	width = 1 / nCol;
	
	idx = 0;
	for iCol = 1 : nCol
		for iRow = 1 : nRow(iCol)
			height = 1 / nRow(iCol);
			bottomPos = (nRow(iCol) - iRow) / nRow(iCol);
			sxPos = (nCol - iCol) / nCol;
			
			idx = idx + 1;
			DBObject = DataBase.findid(find{idx});
			Object = DBObject.load;
			
			MainHandle.Pannel(idx) = uipanel (...
				'Parent', MainHandle.DisplayPannel,...
				'Units', 'normalized',...
				'Position',[sxPos bottomPos width height]);
			
			Object.guidisp(MainHandle.Pannel(idx));

			
			
		end		
		
		
	end
					
					
end


function populatedisplay(id, GHandle)
	
	
	[find, nDisp] = finddependence(GHandle.DataBase, id);


	nRow(2) = fix(nDisp / 2);
	nRow(1) = nDisp - nRow(2);
	nCol = 1 + (nRow(2) > 0);
	
	width = 1 / nCol;
	
	idx = 0;
	for iCol = 1 : nCol
		for iRow = 1 : nRow(iCol)
			height = 1 / nRow(iCol);
			bottomPos =  (iRow - 1) / nRow(iCol);
			sxPos =  (iCol - 1) / nCol;
			
			idx = idx + 1;
			DBObject = GHandle.DataBase.findid(find{idx});
			Object = DBObject.load;
			
			GHandle.Main.Display.SubPanel(idx).Panel = uipanel (...
				'Parent', GHandle.Main.Display.Pannel,...
				'Units', 'normalized',...
				'Position',[sxPos bottomPos width height]);
			
			GHandle.Temp.idx = idx;
			Object.guidisp(GHandle);

			
			
		end		
		
		
	end
					
					
end


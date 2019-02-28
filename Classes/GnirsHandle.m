classdef GnirsHandle < handle

   properties
      Main
	  Viewer
      Viewer3D
	  MethodWindow
	  TempWindow
	  
	  DataBase
	  Preference
	  CurrentDataSet
	  Temp
   end

   methods
       function deleteviewer(obj, viewerhandle)
           obj.Viewer(obj.Viewer == viewerhandle) = [];
       end
   end
end


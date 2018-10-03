classdef ViewerWatchList < handle

   properties (SetObservable) 
      timeLim
	  freqLim
	  
	  colorLine
	  edvLine
	  
	  time2Plot
	  spectrum2Plot
	  timefreq2Plot
   end
end
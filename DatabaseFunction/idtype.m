function [value] = idtype(id, type)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
	if length(id) >= 8
		if nargin == 1
	
			switch id(8)
				case 'A'
					value = 1;
					
				case 'M'
					value = 2;
					
				case 'S'
					value = 3;

				case 'P'
					value = 4;
					
				case 'U'
					value = 5;
					
				case 'T'
					value = 6;

				otherwise
					warning('id not recognised')
					value =  0;
			end
			
		else 
			switch lower(type)
				case 'analysis'
					if id(8) == 'A'
						value =  1;
					else
						value =  0;
					end
					
				case 'measure'
					if id(8) == 'M'
						value =  1;
					else
						value =  0;
					end
					
				case 'study'
					if id(8) == 'S'
						value =  1;
					else
						value =  0;
					end

				case 'probe'
					if id(8) == 'P'
						value =  1;
					else
						value =  0;
					end
					
				case 'subject'
					if id(8) == 'U'
						value =  1;
					else
						value =  0;
					end
					
				case 'atlas'
					if id(8) == 'T'
						value =  1;
					else
						value =  0;
					end

				otherwise
					warning('type not recognised')
					value =  0;
			end
				
		end
	else
		warning('id not valid')
		value =  0;
	end

end


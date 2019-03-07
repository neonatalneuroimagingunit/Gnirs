
% structstruct(S) takes in a structure variable and displays its structure.
%
% INPUTS:
%
% Recursive function 'structstruct.m' accepts a single input of any class.
% For non-structure input, structstruct displays the class and size of the
% input and then exits.  For structure input, structstruct displays the
% fields and sub-fields of the input in an ASCII graphical printout in the
% command window.  The order of structure fields is preserved.
%
% OUTPUTS:
%
% (none yet!)
function structstruct(S)
% Figure the type and class of the input
whosout = whos('S');
sizes = whosout.size;
sizestr = [int2str(sizes(1)),'x',int2str(sizes(2))];
endstr = [':  [' sizestr '] ' whosout.class];
% Print out the properties of the input variable
disp(' ');
disp([inputname(1) endstr]);
% Check if S is a structure, then call the recursive function

fnames = properties(S);
% Check if the i'th field of S is a struct
if isstruct(S) || ~isempty(fnames)
    recursor(S,0,'');
end

% Print out a blank line
disp(' ');
end
function recursor(S,level,recstr)
recstr = [recstr '  |'];

if isstruct(S)
    fnames = fieldnames(S);
else
    fnames = properties(S);
end


for i = 1:length(fnames)
    
    %% Print out the current fieldname
    
    % Take out the i'th field
    tmpstruct = S.(fnames{i});
    
    % Figure the type and class of the current field
    whosout = whos('tmpstruct');
    sizes = whosout.size;
    sizestr = [int2str(sizes(1)),'x',int2str(sizes(2))];
    endstr = [':  [' sizestr '] ' whosout.class];
    
    % Create the strings
    if i == length(fnames) % Last field in the current level
        str = [recstr(1:(end-1)) '''--' fnames{i} endstr];
        recstr(end) = ' ';
    else % Not the last field in the current level
        str = [recstr '--' fnames{i} endstr];
    end
    
    % Print the output string to the command line
    disp(str);
    
    %% Determine if each field is a struct
    spam = properties(tmpstruct);
    % Check if the i'th field of S is a struct
    if isstruct(tmpstruct) || ~isempty(spam) % If tmpstruct is a struct, recursive function call
        recursor(tmpstruct,level+1,recstr); % Call self
    end
    
end
end

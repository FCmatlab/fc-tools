function NewOptions=deleteCellOptions(Options,delOptions)
% FUNCTION NewOptions=fc_tools.utils.deleteCellOptions(Options,delOptions)
%   Delete key/value pairs specified by <delOptions> keys in the cell array 
%   of key/value pairs <Options>
%   Usually used with inputParser (i.e. varargin parameter of a function)
%
% <COPYRIGHT>
assert(iscell(Options))
  if ischar(delOptions),delOptions={ delOptions};end
  n=length(Options);
  isupp=[];
  delOptions=upper(delOptions);
  for i=1:2:n
    I=find(strcmp(upper(Options{i}),delOptions));
    if ~isempty(I)
      isupp=[isupp,i,i+1];
    end
  end
  NewOptions={Options{setdiff(1:n,isupp)}};
end

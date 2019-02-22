function NewOptions=replaceValueOfCellOptions(Options,selOptions,oldValue,newValue)
% FUNCTION fc_tools.utils.replaceValueOfCellOptions
%   Replace a value of selected keys  
%
% <COPYRIGHT>
  assert(iscell(Options))
  if ischar(selOptions),selOptions={ selOptions};end
  n=length(Options);
  isupp=[];
  selOptions=upper(selOptions);
  NewOptions=Options;
  for i=1:2:n
    I=find(strcmp(upper(Options{i}),selOptions));
    if ~isempty(I)
      if strcmp(Options{i+1},oldValue)
        NewOptions{i+1}=newValue;
    end
  end
end

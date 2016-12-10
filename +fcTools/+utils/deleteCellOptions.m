function NewOptions=deleteCellOptions(Options,delOptions)
assert(iscell(Options))
%assert(iscell(dellOptions))
%assert(iscellstr(delOptions));
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

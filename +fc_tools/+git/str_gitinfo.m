function str=str_gitinfo(S)
  sf=fieldnames(S);
  str='{';c='';
  for i=1:length(sf)
    val=getfield(S,sf{i});
    if ischar(val)
      str=[str,sprintf('%s %s:%s',c,sf{i},val)];
    else
      str=[str,sprintf('%s %s: %g',c,sf{i},val)];
    end
    c=',';
  end
  str=[str,'}'];
end

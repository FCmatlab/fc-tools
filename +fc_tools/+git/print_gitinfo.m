function strtime=print_gitinfo(S)
  sf=fieldnames(S);
  for i=1:length(sf)
    val=getfield(S,sf{i});
    if ischar(val)
      fprintf('%7s : %s\n',sf{i},val)
    else
      fprintf('%7s : %g\n',sf{i},val)
    end
  end
end

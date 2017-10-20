function value=find_keyvalue(key,sep,Lines)
% key='Distributor ID' sep=':'
  %C=regexp(lines,key,'split');
  %idx=find(cellfun(@(x) length(x)==2,C));
  fkey=[key,sep];
  idx=find(strncmp(Lines,fkey,length(fkey)));
  assert(length(idx)<=1)
  if ~isempty(idx)
    is=strfind(Lines{idx},sep);
    value=strtrim(Lines{idx}(is+1:end));
  else
    warning('Unable to find key: ''%s''',key);
  end
end
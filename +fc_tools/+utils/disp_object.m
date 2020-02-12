function disp_object(obj)
% FUNCTION disp_object

% <COPYRIGHT>
  fprintf('  %s with properties:\n',class(obj))
  warning off
  names = fieldnames(obj);
  maxnamelen=max(cellfun(@numel,names));
  for i=1:numel(names)
    n=eval(sprintf('size(obj.%s)',names{i}));
    S=fillwith(names{i},' ',maxnamelen+4);
    fprintf('%s: ',S)
    printProperty(obj,names{i})
  end
  warning on
end

function S=fillwith(name,c,nmax)
  n=numel(name);
  S=[repmat(c,1,nmax-n),name];
end

function printProperty(obj,name)
  type=eval(sprintf('class(obj.%s)',name));
  n=eval(sprintf('size(obj.%s)',name));
  if sum(n)==0
    fprintf('[]\n');
  elseif ((n(1)==1) && (n(2)==1))
    if strcmp(type,'struct')
      fprintf('(1x1 struct)\n');
    else
      if strcmp(type,'cell')
        fprintf('(1x1 cell)\n');
      else
        value=eval(sprintf('obj.%s',name));
        fprintf('%g %s\n',value,type);
      end
    end
  else
    if (n(1)==1) && (n(2)<=25)
      value=eval(sprintf('obj.%s',name));
      if isnumeric(value)
        fprintf('[ ');fprintf('%g ',value);fprintf('] ');
      end
    end
    fprintf('(%dx%d %s)\n',n(1),n(2),type);
  end
end

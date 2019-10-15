function str=funHandleName(f,varargin)
  % f=@sin return 'sin'
  % f=@(A,b) gmres(A,b,...) return gmres 
  if fc_tools.utils.isfunhandle(f)
    strf=fc_tools.utils.fun2str(f);
    if strf(2)=='('
      j=strfind(strf,')');
      strf=strf(j(1)+1:end);
      i=strfind(strf,'(');
      if isempty(i)
        str='unknow';
      else
        str=strtrim(strf(1:i(1)-1));
      end
    else
      str=strtrim(strf(2:end));
    end
  else
    error('Parameter must be a function handle')
  end
  p = inputParser;
  p.addParamValue('small', false, @islogical );
  p.parse(varargin{:});
  if p.Results.small
    S=strsplit(str,'.');
    str=S{end};
  end
end

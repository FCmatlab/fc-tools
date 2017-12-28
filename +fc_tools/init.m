function varargout=init(varargin)
% FUNCTION fc_tools.init: For 'compatibility' with my other codes.
%  Can return the pathname of the toolbox.
%
% <COPYRIGHT>
  p = inputParser;
  p.KeepUnmatched=true;
  p.addParamValue('verbose',0,@isscalar);
  p.parse(varargin{:});
  verbose=p.Results.verbose;
  fullname=mfilename('fullpath');
  I=strfind(fullname,filesep);
  mypath=fullname(1:(I(end-1)-1));
  if nargout==1
    fullname=mfilename('fullpath');
    I=strfind(fullname,filesep);
    varargout{1}=mypath;
  end
  if verbose>0
    fprintf('[fc-tools] toolbox/package version [%s] is ready to use!\n',fc_tools.version());
    if verbose>1, fprintf('   -> locate in %s\n',mypath);end
  end
end

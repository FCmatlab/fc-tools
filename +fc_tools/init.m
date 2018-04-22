function varargout=init(varargin)
% FUNCTION fc_tools.init: For 'compatibility' with my other codes.
%  Can return the pathname of the toolbox.
%
% <COPYRIGHT>
  if isOctave()
    warning('off','Octave:shadowed-function')
    more off
  end

  p = inputParser;
  p.KeepUnmatched=true;
  p.addParamValue('verbose',1,@isscalar);
  p.parse(varargin{:});
  verbose=p.Results.verbose;
  fullname=mfilename('fullpath');
  I=strfind(fullname,filesep);
  mypath=fullname(1:(I(end-1)-1));
  addpath(mypath);rehash path;
  if nargout==1
    fullname=mfilename('fullpath');
    I=strfind(fullname,filesep);
    varargout{1}=mypath;
  end
  if verbose>0,fc_tools.info(verbose);end
end

function bool=isOctave()
  log=ver;bool=strcmp(log(1).Name,'Octave');
end

function varargout=init(varargin)
% FUNCTION fcTools.init: For 'compatibility' with my other codes.
%  Can return the pathname of the toolbox.
%
% <COPYRIGHT>
  p = inputParser;
  p.addParamValue('verbose',0,@isscalar);
  p.parse(varargin{:});
  R=p.Results;
  if p.Results.verbose>0
    fprintf('Using mfcTools toolbox [%s]\n',fcTools.version());
  end
  if nargout==1
    fullname=mfilename('fullpath');
    I=strfind(fullname,filesep);
    varargout{1}=fullname(1:(I(end-1)-1));
  end
end
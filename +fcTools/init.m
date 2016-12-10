function init(varargin)
  p = inputParser;
  p.addParamValue('verbose',0,@isscalar);
  p.parse(varargin{:});
  R=p.Results;
  if p.Results.verbose>0
    fprintf('Using mfcTools toolbox [%s]\n',fcTools.version());
  end
end
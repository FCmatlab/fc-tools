function NumV=getNumVersion()
% FUNCTION fc_tools.sys.getNumVersion
%   Returns Matlab or Octave release/version as a scalar
%
% USAGE
%   NumV=getNumVersion()
%
% <COPYRIGHT>
if fc_tools.comp.isOctave()
  Release=version;
  NumV=fc_tools.utils.strversion2num(Release);
else
  R=version('-release');              % R='2016b'
  NumV=str2num(R(1:4))+0.1*((R(5)~='a')+1); % 2016.1 for 'a' release and 2016.2 otherwise
end
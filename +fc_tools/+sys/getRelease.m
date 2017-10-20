function Release=getRelease()
% FUNCTION fc_tools.sys.getNumVersion
%   Returns Matlab or Octave release/version as a scalar
%
% USAGE
%   NumV=getNumVersion()
%
% <COPYRIGHT>
if fc_tools.comp.isOctave()
  Release=version;
else
  Release=version('-release');              % '2016b'
end
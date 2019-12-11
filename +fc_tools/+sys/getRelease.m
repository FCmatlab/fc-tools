function Release=getRelease()
% FUNCTION Release=fc_tools.sys.getRelease()
%   Return Matlab or Octave release/version as a string
%
% USAGE
%   Release=fc_tools.sys.getRelease()
%
% <COPYRIGHT>
if fc_tools.comp.isOctave()
  Release=version;
else
  Release=version('-release');              % '2016b'
end

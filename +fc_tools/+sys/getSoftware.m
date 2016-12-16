function [Softname,Release]=getSoftware()
% FUNCTION fc_tools.sys.getSoftware
%   Returns used software (Matlab or Octave) and its release.
%
% USAGE
%   [Softname,Release]=getSoftware()
%
% <COPYRIGHT>
if fc_tools.comp.isOctave()
  Softname='Octave';
  Release=version;
else
  Softname='Matlab';
  Release=version('-release');
end
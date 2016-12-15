function [Softname,Release]=getSoftware()
% FUNCTION fcTools.sys.getSoftware
%   Returns used software (Matlab or Octave) and its release.
%
% USAGE
%   [Softname,Release]=getSoftware()
%
% <COPYRIGHT>
if fcTools.comp.isOctave()
  Softname='Octave';
  Release=version;
else
  Softname='Matlab';
  Release=version('-release');
end
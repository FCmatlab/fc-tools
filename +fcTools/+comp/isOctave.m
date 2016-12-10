function bool=isOctave()
% FUNCTION bool=fcTools.comp.isOctave() 
%   Returns true if running under Octave 
%
% <COPYRIGHT>
  log=ver;
  bool=strcmp(log(1).Name,'Octave');
end
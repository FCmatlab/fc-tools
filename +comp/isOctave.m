function bool=isOctave()
% function bool=isOctave()
%   returns true if running under Octave
log=ver;
bool=strcmp(log(1).Name,'Octave');
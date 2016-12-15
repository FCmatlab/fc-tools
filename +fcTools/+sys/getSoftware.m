function [Softname,Release]=getSoftware()
if fcTools.comp.isOctave()
  Softname='Octave';
  Release=version;
else
  Softname='Matlab';
  Release=version('-release');
end
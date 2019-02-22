function varargout=getSoftware()
% FUNCTION fc_tools.sys.getSoftware
%   Returns used software (Matlab or Octave) and its release.
%
% USAGE
%   Softname=getSoftware()
%   [Softname,Release]=getSoftware()
%   [Softname,Release,ReleaseAbr]=getSoftware()
%
% <COPYRIGHT>
  if fc_tools.comp.isOctave()
    Softname='Octave';
    Release=version;
    ReleaseAbr=strrep(Release,'.','');
  else
    Softname='Matlab';
    Release=version('-release');
    ReleaseAbr=Release;
  end
  if nargout>=1,varargout{1}=Softname;end
  if nargout>=2,varargout{2}=Release;end
  if nargout==3,varargout{3}=ReleaseAbr;end
end

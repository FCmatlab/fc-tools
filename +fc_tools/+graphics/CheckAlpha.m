function varargin=CheckAlpha(varargin,toolboxname,funcname)
  if fc_tools.comp.isOctave()
    NotImplemented={'FaceAlpha','EdgeAlpha'};
    nv=length(varargin);
    varargin=fc_tools.utils.deleteCellOptions(varargin,NotImplemented);
    if length(varargin)<nv
      fprintf('[%s] ''FaceAlpha'' or ''EdgeAlpha'' not yet implemented in %s\n',toolboxname,funcname);
    end
  end
end
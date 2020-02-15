function varargin=CheckAlpha(varargin,toolboxname,funcname)
  if fc_tools.comp.isOctave()
    if fc_tools.utils.getNumVersion()<fc_tools.utils.strversion2num('4.4.0')
      NotImplemented={'FaceAlpha','EdgeAlpha'};
      nv=length(varargin);
      varargin=fc_tools.utils.deleteCellOptions(varargin,NotImplemented);
      if length(varargin)<nv
        fprintf('[%s] ''FaceAlpha'' or ''EdgeAlpha'' not yet implemented in %s\n',toolboxname,funcname);
      end
    end
  end
end

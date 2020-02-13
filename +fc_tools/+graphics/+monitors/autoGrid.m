function autoGrid(varargin)
  [nf,hfigs]=fc_tools.graphics.getNbfigs();
  if nf==0,return;end
%    if strcmp(class(hfigs(1)),'matlab.ui.Figure')
%      figures=[hfigs(:).Number];
%    else
%      if fc_tools.comp.isOctave(),figures=nf:-1:1;else, figures=1:nf;end
%    end
  %keyboard
  disp(1)
  [nrows,ncols]=fc_tools.graphics.monitors.autoGridSize(nf);
  disp(2)
  if strcmp(class(hfigs(1)),'matlab.ui.Figure')
    %I={hfigs(:).Number};
    [~,figures]=sort([hfigs(:).Number]);
  else
    if fc_tools.comp.isOctave(),figures=flip(hfigs);else, figures=hfigs;end
  end
  disp(3)
  fc_tools.graphics.monitors.onGrid(nrows,ncols,'figures',figures,varargin{:})
  disp(4)
end

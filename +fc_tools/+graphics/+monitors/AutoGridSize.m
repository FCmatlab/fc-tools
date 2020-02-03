function [varargout]=AutoGridSize(nf)
  %nf: number of figures
  assert(ismember(nargout,[2,3]))
  mFontSize=[8,6,6,6];oFontSize=[8,6,6,6]; %default
  if nf<=1,return;end
  if nf<=4, nrow=2;ncol=2;mFontSize=[10,8,8,8];oFontSize=[16,14,14,14];
  elseif nf<=6, nrow=2;ncol=3;oFontSize=[12,10,10,10];
  elseif nf<=9, nrow=3;ncol=3;mFontSize=[8,5,6,6];oFontSize=[12,10,10,10];
  elseif nf<=12, nrow=3;ncol=4;
  elseif nf<=16, nrow=4;ncol=4;
  elseif nf<=20, nrow=4;ncol=5;
  elseif nf<=25, nrow=5;ncol=5;
  elseif nf<=30, nrow=5;ncol=6;
  elseif nf<=36, nrow=6;ncol=6;
  else, error('to many figures');end
  varargout{1}=nrow;varargout{2}=ncol;
  if nargout==3
    if fc_tools.comp.isOctave()
      varargout{3}=oFontSize;
    else
      varargout{3}=mFontSize;
    end
  end
end

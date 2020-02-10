function varargout=getNbfigs()
  % return number of figures
  figHandles = get(0,'Children');
  nf=length(figHandles);
  varargout{1}=nf;
  if nargout==2, varargout{2} = figHandles;end
end

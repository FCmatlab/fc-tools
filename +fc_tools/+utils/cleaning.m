function cleaning(verbose)
  if nargin==0, verbose=0;end
  if length(dbstack)<=2
    if verbose~=0
      fprintf('[fc-tools] Cleaning...\n')
    end
    clear all
    close all
  end
end

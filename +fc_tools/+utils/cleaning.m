function cleaning(verbose)
  if nargin==0, verbose=0;end
  if verbose~=0
      fprintf('[fc-tools] Cleaning...\n')
    end
  if length(dbstack)<=2
    clear all
  end
  close all
end

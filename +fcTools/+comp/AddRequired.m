function p=AddRequired(p,varargin)
% FUNCTION p=fcTools.comp.AddRequired(p,varargin)
%   Alternative function for addRequired - Suitable for Matlab and any 
%   Octave version.
%   Adds a required argument to the input scheme.
%
% Input and output parameter:
% p : inputParser object
%
% <COPYRIGHT>
  if isOldParser()
    p=p.addRequired(varargin{:});
  else
    p.addRequired(varargin{:});
  end
end

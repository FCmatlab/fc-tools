function p=AddParamValue(p,varargin)
% FUNCTION p=fcTools.comp.AddParamValue(p,varargin)
%   Alternative function for addParamValue - Suitable for Matlab and any 
%   Octave version.
%   Adds a name-value argument to the input scheme.
%
% Input and output parameter:
% p : inputParser object
%
% <COPYRIGHT>
  if isOldParser()
      p=p.addParamValue(varargin{:});
  else
      p.addParamValue(varargin{:});
  end
end
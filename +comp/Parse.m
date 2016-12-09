function p=Parse(p,varargin)
% function p=Parse(p,varargin)
% Alternative function for parse - Suitable for Matlab and any Octave version
% To parse and validate input arguments.
%
% Input and output parameter:
% p : inputParser object
%

  if isOldParser()
    p=p.parse(varargin{:});
  else
    p.parse(varargin{:});
  end
end
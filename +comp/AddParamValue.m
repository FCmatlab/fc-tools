function p=AddParamValue(p,varargin)
% function p=AddParamValue(p,varargin)
% Alternative function for addParamValue - Suitable for Matlab and any Octave version
% Adds a name-value argument to the input scheme.
%
% Input and output parameter:
% p : inputParser object
%

if isOldParser()
    p=p.addParamValue(varargin{:});
else
    p.addParamValue(varargin{:});
end
end
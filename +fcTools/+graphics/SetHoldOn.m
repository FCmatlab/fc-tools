function pIH=SetHoldOn(HoldOn)
% FUNCTION fcTools.graphics.SetHoldOn
%
% <COPYRIGHT>
pIH=ishold;
if ((~pIH)&&(HoldOn))
  hold on
end
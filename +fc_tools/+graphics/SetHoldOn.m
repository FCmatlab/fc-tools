function pIH=SetHoldOn(HoldOn)
% FUNCTION fc_tools.graphics.SetHoldOn
%
% <COPYRIGHT>
pIH=ishold;
if ((~pIH)&&(HoldOn))
  hold on
end
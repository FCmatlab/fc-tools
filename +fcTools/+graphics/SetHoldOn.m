function pIH=SetHoldOn(HoldOn)
pIH=ishold;
if ((~pIH)&&(HoldOn))
  hold on
end
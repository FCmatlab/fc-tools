function view3D()
  [AZ,EL] = view();
  if (AZ==0 && EL==90), view(3);end
end
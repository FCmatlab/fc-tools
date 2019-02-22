function is2D=is2Dview() 
  [az,el]=view();
  is2D= (az==0 & el==90);
end

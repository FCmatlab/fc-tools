Add-Type -AssemblyName System.Windows.Forms 
[System.Windows.Forms.Screen]::AllScreens 
([System.Windows.Forms.Screen]::AllScreens | select -expandproperty workingarea)
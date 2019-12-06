% DON'T CHANGE THIS FILE if not in FC-EXAMPLE package
%   automaticaly updated from FC-EXAMPLE package with update_package command
% 
function BuildVersions(pkg,pkgs)
  strfootnote='\\LaTeX\\ manual, revision \\fctagdoc, compiled with \\fccmdname~\\fccmdversion';
  
  n_pkgs=length(pkgs);
  if n_pkgs==0, strfootnote=[strfootnote,', and \\ToolboxPackageName\\ '];end
  if n_pkgs>0,  strfootnote=[strfootnote,', and \\ToolboxPackageNames\\ '];end
  eval(sprintf('v=fc_%s.version();',pkg));
  strfootnote=[strfootnote,'\\texttt{fc-',pkg,'}[',v,']'];  
  fprintf('\\newcommand{\\fc%sversion}{%s}\n',RepNum(pkg),v);
  if n_pkgs>0, strfootnote=[strfootnote,', '];end
  for i=1:n_pkgs
    eval(sprintf('v=fc_%s.version();',pkgs{i}));
    fprintf("\\newcommand{\\fc%sversion}{%s}\n",RepNum(pkgs{i}),v);
    strfootnote=[strfootnote,'\\texttt{fc-',pkgs{i},'}[',v,']'];
    if i<n_pkgs, strfootnote=[strfootnote,', '];end
  end
  fprintf(['\\newcommand{\\fctitlefootnote}{',strfootnote,'}\n']);
  eval(sprintf('P=fc_%s.path();',pkg));
  fprintf(['\\newcommand{\\FCTOOLBOXDIR}{',P,'}']);
  fprintf(['\\renewcommand{\\fctoolboxdir}{',P,'}']); % already set in cmd.tex with builtex_octave or
end


function Name=RepNum(name)
  Name=strrep(name,'2','TO');
  Name=strrep(Name,'4','FoR');
end

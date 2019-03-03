function env=environment(varargin)
% FUNCTION env=fc_tools.environment()
%   Retrieves the toolbox/package environment directories.
%
% <COPYRIGHT>
  [pkg,pkgs]=fc_tools.packages();
  eval(['[conffile,isFileExists]=fc_',pkg,'.getLocalConfFile();'])
  if ~isFileExists
    fprintf('Try to use default parameters!\n Use fc_%s.configure to configure.\n',pkg)
    eval(['fc_',pkg,'.configure();']);
  end
  run(conffile);
  for i=1:length(pkgs)
    eval(sprintf('env.fc_%s_dir=fc_%s_dir;',pkgs{i},pkgs{i}));
  end
  env.pkgs=pkgs;
  fullname=mfilename('fullpath');
  I=strfind(fullname,filesep);
  Path=fullname(1:(I(end-1)-1));
  env.Path=Path; % current toolbox path
end

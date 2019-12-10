function SaveAllFigsAsFiles(basename,varargin)
% FUNCTION fc_tools.graphics.SaveAllFigsAsFiles
%   Save all figures in current directory with file names
%       <basename>_fig<fignumber>.eps
%   by using print command, where <basename> is the string value of the input 
%   parameter and <fignumber> is the number of the figure to be saved.
% USAGE
%   fc_tools.graphics.SaveAllFigsAsFiles(basename)
%   fc_tools.graphics.SaveAllFigsAsFiles(basename, <key>, <value>, ...)
%
%   Parameter <basename> is used to specify the first part of the saved files
%   (one per figures). This parameter can be followed by key/value pairs to 
%   specify options. The keys will be the strings:
%     * 'format':
%       To specify the file format of saved files (default 'epsc').
%       Authorized formats are 'png','pdf','eps'
%     * 'dir':
%       To specify the directory for saving files. 
%       Default is '.' (current directory)
%     * 'size':
%       To specify the size of the images to be saved.
%       Default is [800,600].
%     * 'tag':
%       If true a special tag is added when building file names:
%           <basename>_fig<fignumber>_<software><release>.eps
%       where <software> is name of the current software (Matlab or Octave)
%       and <release> its current version/release.
%       Default is false.
%     * 'printoptions':
%       To specify options passed to print command as cell array: one option 
%       by cell. Default is an empty cell.
%
% SAMPLES
%   fc_tools.graphics.SaveAllFigsAsFiles('test1')
%   fc_tools.graphics.SaveAllFigsAsFiles('test2','format','png','dir','./figures','size',[1024,768])
%   fc_tools.graphics.SaveAllFigsAsFiles('test3','format','pdf','printoptions',{'-fillpage'}) % Only Matlab option
%
%    <COPYRIGHT> 

  p = inputParser;
  p.KeepUnmatched=true; 
  p.PartialMatching=false;
  p.addParamValue('format','epsc',@(x) ismember(lower(x),{'epsc','pdf','png'}));
  p.addParamValue('showtitle',true,@islogical);
  p.addParamValue('verbose',false,@islogical);
  p.addParamValue('dir','.',@ischar);
  p.addParamValue('pdfcrop',false,@islogical); % experimental use pdfcrop command under linux
  p.addParamValue('crop',false,@islogical); % experimental 
  p.addParamValue('pause',2,@isscalar);
  p.addParamValue('size',[800,600]);
  p.addParamValue('visible','off');
  p.addParamValue('tag',false,@islogical);
  p.addParamValue('printoptions',{},@iscell);
  p.parse(varargin{:});
  R=p.Results;
  varargin=fc_tools.utils.deleteCellOptions(varargin,p.Parameters);
  if R.tag, [Softname,Release]=fc_tools.sys.getSoftware();end
  %if isOctave, more off;end  
  figHandles = get(0,'Children');
  for i=1:length(figHandles)
    if strcmp(class(figHandles(1)),'matlab.ui.Figure')
      nfig=figHandles(i).Number;
      figname=num2str(nfig);
      h=figHandles(i);
    else % old version
      nfig=figHandles(i);
      figname=num2str(nfig);
      h=figHandles(i);
    end
    %h=figure(nfig); % utiliser le label...
    position=get(h,'position');
    set(h,'position',[position(1),position(2),R.size(1),R.size(2)])
    if ~R.showtitle
      
      Title=get(gca(),'Title');
      set(Title,'Visible','off')
    end
    set(h,'Color',[1,1,1]) % white backgroup for print
    if ~fc_tools.sys.isfolder(R.dir)
      [status, msg, msgid]=mkdir(R.dir);
      if status==0, error(msg);end
    else
      assert(exist(R.dir)==7)
    end
    if R.tag
      %filename=[R.dir,filesep,file,'_fig',figname,'_',Softname,strrep(Release,'.',''),'.',R.format];
      filename=[R.dir,filesep,basename,'_fig',figname,'_',Softname,strrep(Release,'.','')];
    else
      %filename=[R.dir,filesep,file,'_fig',figname,'.',R.format];
      filename=[R.dir,filesep,basename,'_fig',figname];
    end
    ext=get_ext(R.format);
    if ~isempty(ext), filename=[filename,'.',ext];end
    if fc_tools.comp.isOctave()
      if str2num(strrep(version,'.',''))>=420 % version 4.2.0
        drawnow
        print(h,filename,['-d',R.format],R.printoptions{:})
        pause(0.1) % otherwise sometimes bug with some legends!
      else % Don't print "LaTeX" so snapshot
        set(h,'position',[100,50,R.size(1),R.size(2)])
        SaveOctaveFigure(nfig,[filename,'.',R.format])
        set(h,'visible','off') % BUG1: ajout car la derniere figure reste en avant plan avec Octave 4.2.0!
      end
    else
      print(h,filename,['-d',R.format],R.printoptions{:})
    end
    if ~R.showtitle
      set(Title,'Visible',R.visible)
    end
    if R.pdfcrop
      if ~fc_tools.comp.isOctave()
      system(sprintf('pdfcrop %s %s',filename,filename));   
      end
    end
    if R.crop
      fc_tools.graphics.crop.crop(filename);
    end
    if R.verbose
      fprintf('  Save figure %d in %s\n',nfig,filename);
    end
  end
  if fc_tools.comp.isOctave() %BUG1:
    for i=1:length(figHandles)
      %nfig=figHandles(i);
      %h=figure(nfig); % utiliser le label...
      set(figHandles(i),'visible',R.visible) 
    end
  end
  if R.pause>0
    fprintf('[fc-tools] waiting %g(s) to finish saving figures\n',R.pause) % Add for BUG in Matlab/Ubuntu 14.04 LTS
    pause(R.pause)
  end
end

function SaveOctaveFigure(nfig,filename)
  h=figure(nfig);
  set(h,'menubar','none')
  P=get(h,'position');
  if ismac()
  command=sprintf('screencapture -R %d,%d,%d,%d %s',P(1),P(2)+100,P(3),P(4)-50,filename);
  else
  % use imagemagick
  command=sprintf('import -window root -gravity SouthWest -crop %dx%d+%d+%d %s',P(3)-2,P(4)-30,P(1)+1,P(2)+1,filename)
  end
  drawnow
  pause(2);
  system(command)
  pause(2);
  set(h,'menubar','figure')
end

function figuresize( fighandle, varargin )
  p = inputParser;
  p.addParamValue('scale',1,@(x) isscalar(x) )

  p.parse( varargin{:});
  scale = p.Results.scale;
  set(fighandle,'visible','off')
  screenpos = get(fighandle,'Position');

  set(fighandle,'Position',[screenpos(1:2) scale*screenpos(3:4)]);
  set(fighandle,'visible','on')
end

function ext=get_ext(format)
  switch lower(format)
  case 'png'
    ext='png';
  case {'eps','epsc','epsc2'}
    ext='eps';
  case {'jpg','jpeg'}
    ext='jpg';
  case 'pdf'
    ext='pdf';
  otherwise
    ext='';
  end
end

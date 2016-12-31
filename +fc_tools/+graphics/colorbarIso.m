function varargout=colorbarIso(colors,isorange,format)
% from http://www.mathworks.com/matlabcentral/fileexchange/1135-colorbarf/content/colorbarf.m
  if nargin<3, format='%g';end
%    if isOctave()
%      warning('colorbarIso function not yet Octave compatible')
%      return
%    end
  minc = min(colors);
  maxc = max(colors);
  h = gca;
  origNextPlot = get(gcf,'NextPlot');
  units = get(h,'units'); set(h,'units','normalized')
  pos = get(h,'Position');
  [az,el] = view;
  stripe = 0.075; edge = 0.02;
  if all([az,el]==[0 90]), space = 0.05; else space = .1; end
  set(h,'Position',[pos(1) pos(2) pos(3)*(1-stripe-edge-space) pos(4)])
  rect = [pos(1)+(1-stripe-edge)*pos(3) pos(2) stripe*pos(3) pos(4)];
  ud.origPos = pos;

  % Create axes for stripe and
  % create DeleteProxy object (an invisible text object in
  % the target axes) so that the colorbar will be deleted
  % properly.
  ud.DeleteProxy = text('parent',h,'visible','off',...
			'tag','ColorbarDeleteProxy',...
			'handlevisibility','off',...
	'deletefcn','eval(''delete(get(gcbo,''''userdata''''))'','''')');
  ax = axes('Position', rect,'Tag','TMW_COLORBAR');
  set(ud.DeleteProxy,'userdata',ax)
  set(h,'units',units)
  hold on
  if any(isnan(colors)) % if the bottom level is not filled
    for j = 1:length(isorange)
      k = j - 1; % don't fill bottom rectangle on colorbar
      x(1) = 0;
      x(2) = 1;
      x(3) = 1;
      x(4) = 0;
      y(1) = (j-1)*(1/(length(isorange)));
      y(2) = (j-1)*(1/(length(isorange)));
      y(3) = j*(1/(length(isorange)));
      y(4) = j*(1/(length(isorange)));
      if (k == 0)
	  hfill = fill(x,y,colors(length(colors),:)); % fill with NaN
      else
	  
	  hfill = fill(x,y,colors(k,:));
      end
      %hold on
    end
  else %we have filled the bottom contour level
    for j = 1:length(isorange)
      x(1) = 0;
      x(2) = 1;
      x(3) = 1;
      x(4) = 0;
      y(1) = (j-1)*(1/(length(isorange)));
      y(2) = (j-1)*(1/(length(isorange)));
      y(3) = j*(1/(length(isorange)));
      y(4) = j*(1/(length(isorange)));
      hfill = fill(x,y,[colors(j,:)]);
      %hold on
     end
  end
  set(ax,'YAxisLocation','right')
  set(ax,'xtick',[])
  ylimits = get(gca,'ylim');
  myYticks = ylimits(1):(ylimits(2)-ylimits(1))/(length(isorange)):ylimits(2)...
      -((ylimits(2)-ylimits(1))/(length(isorange)));
  myYticks = myYticks+(ylimits(2)-ylimits(1))/(2*length(isorange));
  set(gca,'ytick',myYticks);

  %myStr{1} = ' ';
  for kk = 1:length(isorange)
      myStr{kk} = sprintf(format,isorange(kk));%num2str(isorange(kk));
  end
  myStr{(length(isorange)+2)} = ' ';
  set(gca,'YTickLabel',myStr)
  %set(gca,'CLim',[minc maxc])

  % set up axes deletefcn
  set(ax,'tag','Colorbar','deletefcn','colorbar(''delete'')')
  if nargout==1, varargout{1}=ax;end
  if ~isfield(ud,'DeleteProxy'), ud.DeleteProxy = []; end
  if ~isfield(ud,'origPos'), ud.origPos = []; end
  ud.PlotHandle = h;
  set(ax,'userdata',ud)
  set(gcf,'CurrentAxes',h)
  set(gcf,'NextPlot',origNextPlot)
end


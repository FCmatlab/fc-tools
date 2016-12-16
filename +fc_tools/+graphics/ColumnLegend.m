function [legend_h,object_h,plot_h,text_strings] = ColumnLegend(numcolumns,handles , str, varargin)
% fc_tools.graphics.ColumnLegend : just an interface to fc_tools.graphics.columnlegend.columnlegend
[legend_h,object_h,plot_h,text_strings] =fc_tools.graphics.columnlegend.columnlegend(numcolumns,handles , str, varargin);
end
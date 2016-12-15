function [legend_h,object_h,plot_h,text_strings] = ColumnLegend(numcolumns,handles , str, varargin)
% fcTools.graphics.ColumnLegend : just an interface to fcTools.graphics.columnlegend.columnlegend
[legend_h,object_h,plot_h,text_strings] =fcTools.graphics.columnlegend.columnlegend(numcolumns,handles , str, varargin);
end
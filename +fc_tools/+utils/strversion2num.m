function ver=strversion2num(strv)
% convert version string 'x.y.z' in x*10^6+y*10^3+z
S=strsplit(strv,'.');
assert(length(S)==3);
z=str2num(S{3});assert(z<10^3);
ver=z;
y=str2num(S{2});assert(y<10^3);
ver=ver+10^3*y;
x=str2num(S{1});assert(x<10^3);
ver=ver+10^6*x;
end
# DON'T CHANGE THIS FILE if not in fc-tools package
#   automaticaly updated from fc-tools package with update_package command
# 

import platform,socket,os,pwd,sys

#hostname=socket.gethostname()

def get_hostname():
  return platform.uname()[1]

def get_username():
    return pwd.getpwuid( os.getuid() )[ 0 ]
  
def search_command(filename,cmdname):
  with open(filename) as f:
    for line in f:
       A=line.split('=',1)
       Name=A[0].strip()
       if Name==cmdname:
         return A[1].strip()
       #print(line)
  print('Not found %s'%cmdname)
  return ''

hostname=get_hostname()
hostname=hostname.split('.',1)[0]
conffile=hostname+'_'+get_username()+'.inc'

assert len(sys.argv)==3 or len(sys.argv)==2 ,' Must have one or two input arguments'
Soft=sys.argv[1]
if len(sys.argv)==3:
  Release=sys.argv[2]
  S=search_command(conffile,Soft+'_'+Release)
  if len(S)==0:
    print('%s_%s not found in %s!\n',Soft,Release,conffile)
  else:  
    print(S[1:-1])
else:
  S=search_command(conffile,Soft)
  if len(S)==0:
    print('%s not found in %s!\n',Soft,conffile)
  else:
    if S[0]=='"' and S[-1]=='"':
      print(S[1:-1])
    else:
      print(S)
  

#fid.close()

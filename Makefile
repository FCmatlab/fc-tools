# fc-tools : Matlab Toolbox and Octave (>= 4.0.3) package

HOSTNAME = $(shell hostname -s)
USERNAME = $(shell whoami)
CURRENT_DIR = $(shell pwd)

OCOPYRIGHT=%    Parts of GNU Octave <fc-tools> package.\n%    Copyright (C) 2016-2017 Francois Cuvelier <cuvelier@math.univ-paris13.fr>\n%
MCOPYRIGHT=%    Parts of Matlab <fc-tools> toolbox.\n%    Copyright (C) 2016-2017 Francois Cuvelier <cuvelier@math.univ-paris13.fr>\n%

NAME=fc_tools
GIT_REPO=/home/cuvelier/Travail/Recherch/Matlab

DEFAULT_TAG=0.0.13
ifeq ("$(TAG)","")
TAG=$(DEFAULT_TAG)
endif

TAGTIMEcmd := git log --tags --simplify-by-decoration --pretty="format:%ci %d" |grep -E "($(TAG),|$(TAG)\))" |awk '{print $$1,$$2,$$3 }'
TAGTIME := $(shell $(TAGTIMEcmd) )

GITTAGNAMEcmd:= git describe --tags
GITTAGNAME:= $(shell $(GITTAGNAMEcmd))
GITDATEcmd:=git log -1 --pretty="format:%at" | awk 'BEGIN { FS="|" } ; { t=strftime("%Y-%m-%d",$$1); printf "%s\n", t}'
GITDATE:= $(shell $(GITDATEcmd))
GITTIMEcmd:=git log -1 --pretty="format:%at" | awk 'BEGIN { FS="|" } ; { t=strftime("%H:%M:%S",$$1); printf "%s\n", t}'
GITTIME:= $(shell $(GITTIMEcmd))
GITCOMMITcmd:=git log -1 --pretty="format:%H"
GITCOMMIT:= $(shell $(GITCOMMITcmd))



CURRENT_DIR = $(shell pwd)
#DESTDIR=distrib/$(VERSION)
MATLAB_DESTDIR=distrib/Matlab/$(VERSION)
OCTAVE_DESTDIR=distrib/Octave/$(VERSION)

# For archive temporary directory
FILENAME=fc_tools
OCTAVE_PKG=fc-tools

VERSION=$(TAG)
MATLAB_NAME=$(FILENAME)
OCTAVE_NAME=$(FILENAME)

OFILENAME := $(OCTAVE_NAME)-$(VERSION)
MFILENAME := $(MATLAB_NAME)-$(VERSION)
OCTAVE_PKG_VERSION := $(OCTAVE_PKG)-$(VERSION)

OCTAVE_INST_MOVE= +fc_tools 

matlabtar : setversion GITCOMMIT setcopyright
	@python3 extractfiles.py matlab.list > matlab.tmp
	@echo "\nCreating files $(MFILENAME).tar.gz, $(MFILENAME).zip and $(MFILENAME).7z and size files ...\n"
	@$(eval tmpdir := $(shell mktemp -d))
	@echo $(tmpdir)
	@(tar zcf $(tmpdir)/matlabtmp.tar.gz -T matlab.tmp)
	@(cd $(tmpdir) && mkdir $(MFILENAME) && cd $(MFILENAME) && tar zxf ../matlabtmp.tar.gz )
	@(cd $(tmpdir) && tar zcf $(MFILENAME).tar.gz $(MFILENAME) )
	@(cd $(tmpdir) && zip --symlinks -r $(MFILENAME).zip $(MFILENAME) )
	@(cd $(tmpdir) && 7z a $(MFILENAME).7z $(MFILENAME) )
	@mkdir -p $(MATLAB_DESTDIR)
	@(mv -f $(tmpdir)/$(MFILENAME).7z $(tmpdir)/$(MFILENAME).tar.gz $(tmpdir)/$(MFILENAME).zip $(MATLAB_DESTDIR))
	@rm -fr $(tmpdir)
	@echo "\nCreating files\n  -> $(MFILENAME).tar.gz,\n  -> $(MFILENAME).zip,\n  -> $(MFILENAME).7z"
	@echo "in directory $(MATLAB_DESTDIR)\n"
	
octavetar : setversion GITCOMMIT setcopyright
	@python3 extractfiles.py octave.list > octave.tmp
	@echo "\nCreating files $(OFILENAME).tar.gz, $(OFILENAME).zip and $(OFILENAME).7z and size files ...\n"
	@$(eval tmpdir := $(shell mktemp -d))
	@echo "Building in temprary directoru : $(tmpdir)"
	@tar  -zhcf $(tmpdir)/octavetmp.tar.gz -T octave.tmp
	@(mkdir -p $(tmpdir)/$(OFILENAME))
	@(tar zxf $(tmpdir)/octavetmp.tar.gz -C $(tmpdir)/$(OFILENAME))
	@(cd $(tmpdir) && tar zcf $(OFILENAME).tar.gz $(OFILENAME))
	@mkdir -p $(OCTAVE_DESTDIR)
	@(cd $(tmpdir) && zip --symlinks -r $(OFILENAME).zip $(OFILENAME))
	@(cd $(tmpdir) && 7z a $(OFILENAME).7z $(OFILENAME))
	@(cd $(tmpdir)/$(OFILENAME) && mkdir -p inst; mv $(OCTAVE_INST_MOVE) inst/ )
	@(cd $(tmpdir) && mv $(OFILENAME) $(OCTAVE_PKG))
	@(cd $(tmpdir) && tar zcvf $(OCTAVE_PKG_VERSION).tar.gz $(OCTAVE_PKG))
	@(mv -f $(tmpdir)/$(OFILENAME).7z $(tmpdir)/$(OCTAVE_PKG_VERSION).tar.gz $(tmpdir)/$(OFILENAME).tar.gz $(tmpdir)/$(OFILENAME).zip $(OCTAVE_DESTDIR))
	@echo "Cleaning"
	@rm -fr $(tmpdir) octave.tmp 
	@echo "\nCreating files\n  -> $(OCTAVE_PKG_VERSION).tar.gz,\n  -> $(OFILENAME).tar.gz,\n  -> $(OFILENAME).zip,\n  -> $(OFILENAME).7z"
	@echo "in directory $(OCTAVE_DESTDIR)\n"
	
setversion:
	@echo "Set version to $(TAG)"
	$(shell sed -i "s/v='.*';/v='$(TAG)';/g" +fc_tools/version.m)
	$(shell sed -i "s/Version:.*/Version: $(TAG)/g" DESCRIPTION)
	$(shell sed -i "s/Date:.*/Date: $(TAGTIME)/g" DESCRIPTION)
	@sed -i "s/tag=.*/tag='$(GITTAGNAME)';/g" +fc_tools/gitinfo.m
	@sed -i "s/commit=.*/commit='$(GITCOMMIT);'/g" +fc_tools/gitinfo.m
	@sed -i "s/date=.*/date='$(GITDATE)';/g" +fc_tools/gitinfo.m
	@sed -i "s/time=.*/time='$(GITTIME)';/g" +fc_tools/gitinfo.m

setcopyright:
ifneq ("$(SETCOPYRIGHT)","")
	@echo "Set copyright to :\n$(SETCOPYRIGHT)\n"
	@$(eval filelist:= $(shell find . -name "*.m"))
	@sed -i "s/% <COPYRIGHT>*/$(SETCOPYRIGHT)/" $(filelist)
endif

SEP="***************************************************"

archives: archives_matlab archives_octave macoui

archives_matlab : 
	@echo $SEP
	@echo "*** Building MATLB archives"
	@echo "*** Start main Makefile command" 
	@echo "*** Current directory $(CURRENT_DIR)"
	@$(eval gitremote := $(shell git config --get remote.origin.url))
	@$(eval tmpdir := $(shell mktemp -d))
	@echo $(SEP)
	@echo "***1) Clone $(gitremote) [tag=$(TAG)]\n***    in directory $(tmpdir)/$(FILENAME)"
	@echo $(SEP)
	@(cd $(tmpdir) && git clone --quiet $(gitremote) $(FILENAME) )
	@(cd $(tmpdir)/$(FILENAME) && git checkout --quiet tags/$(TAG) -b temporary )
	@echo $(SEP)
	@echo "***2) make MATLAB archives"
	@echo $(SEP)
	@(cd $(tmpdir)/$(FILENAME) && make TAG=$(TAG) SETCOPYRIGHT="$(MCOPYRIGHT)" matlabtar)
	@echo $(SEP)
	@echo "***3) transfert archives to $(MATLAB_DESTDIR)"
	@echo $(SEP)
	@mkdir -p $(MATLAB_DESTDIR)
	@(rsync -av $(tmpdir)/$(FILENAME)/$(MATLAB_DESTDIR)/* $(MATLAB_DESTDIR))
	@rm -fr $(tmpdir)
ifneq ("$(HOSTNAME)","hercule")
	@echo "********************************************"
	@echo "DON'T FORGET TO UPDATE TO <hercule> COMPUTER"
	@echo "********************************************"
	@echo "         make TAG=$(TAG) hercule"
endif
	
archives_octave : 
	@echo $SEP
	@echo "*** Building OCTAVE archives"
	@echo "*** Start main Makefile command" 
	@echo "*** Current directory $(CURRENT_DIR)"
	@$(eval gitremote := $(shell git config --get remote.origin.url))
	@$(eval tmpdir := $(shell mktemp -d))
	@echo $(SEP)
	@echo "***1) Clone $(gitremote) [tag=$(TAG)]\n***    in directory $(tmpdir)/$(FILENAME)"
	@echo $(SEP)
	@(cd $(tmpdir) && git clone --quiet $(gitremote) $(FILENAME) )
	@(cd $(tmpdir)/$(FILENAME) && git checkout --quiet tags/$(TAG) -b temporary )
	@echo $(SEP)
	@echo "***2) make OCTAVE archives"
	@echo $(SEP)
	@(cd $(tmpdir)/$(FILENAME) && make TAG=$(TAG) SETCOPYRIGHT="$(OCOPYRIGHT)" octavetar)
	@echo $(SEP)
	@echo "***3) transfert archives to $(OCTAVE_DESTDIR)"
	@echo $(SEP)
	@mkdir -p $(OCTAVE_DESTDIR)
	@(rsync -av $(tmpdir)/$(FILENAME)/$(OCTAVE_DESTDIR)/* $(OCTAVE_DESTDIR))
	@rm -fr $(tmpdir)
ifneq ("$(HOSTNAME)","hercule")
	@echo "********************************************"
	@echo "DON'T FORGET TO UPDATE TO <hercule> COMPUTER"
	@echo "********************************************"
	@echo "         make TAG=$(TAG) hercule"
endif

macoui: macoui_matlab macoui_octave
ifneq ("$(HOSTNAME)","hercule")
	@echo "********************************************"
	@echo "DON'T FORGET TO UPDATE TO <hercule> COMPUTER"
	@echo "********************************************"
	@echo "         make TAG=$(TAG) hercule"
endif
	
macoui_matlab:
	@echo "Transfert Matlab/fc-tools -> MACOUI"
	ssh macoui 'mkdir -p ~/public_html/software/codes/Matlab/fc-tools'
	rsync -av $(MATLAB_DESTDIR) macoui:~/public_html/software/codes/Matlab/fc-tools/
	
macoui_octave:
	@echo "Transfert Octave/fc-tools -> MACOUI"
	ssh macoui 'mkdir -p ~/public_html/software/codes/Octave/fc-tools'
	rsync -av $(OCTAVE_DESTDIR) macoui:~/public_html/software/codes/Octave/fc-tools/
	
hercule:
ifeq ("$(HOSTNAME)","hercule")
	@echo "Nothing to I'm hercule computer!"
else
	@echo "*** Synchronize  $(MATLAB_DESTDIR)"
	@ssh 192.168.0.14 "mkdir -p ~/Travail/Recherch/Matlab/$(NAME)/$(MATLAB_DESTDIR)"
	@rsync -avz $(MATLAB_DESTDIR)/* 192.168.0.14:~/Travail/Recherch/Matlab/$(NAME)/$(MATLAB_DESTDIR)/
	@echo "*** Synchronize  $(OCTAVE_DESTDIR)"
	@ssh 192.168.0.14 "mkdir -p ~/Travail/Recherch/Matlab/$(NAME)/$(OCTAVE_DESTDIR)"
	@rsync -avz $(OCTAVE_DESTDIR)/* 192.168.0.14:~/Travail/Recherch/Matlab/$(NAME)/$(OCTAVE_DESTDIR)/
endif

last_tag:
	@echo "$(NAME): "$(shell git describe --abbrev=0)
	
GIT:
	@echo "$(GITTAGNAME):$(GITDATE):$(GITTIME):$(GITCOMMIT)"
	
GITCOMMIT :
	@echo "Build GITCOMMIT file"
	@git config --get remote.origin.url > GITCOMMIT
	@git rev-parse HEAD >> GITCOMMIT

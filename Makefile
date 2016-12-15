# fc-tools : Matlab Toolbox and Octave (>= 4.0.3) package

OCOPYRIGHT=%    Parts of GNU Octave <fc-tools> package.\n%    Copyright (C) 2016 Francois Cuvelier <cuvelier@math.univ-paris13.fr>\n%
MCOPYRIGHT=%    Parts of Matlab <fc-tools> toolbox.\n%    Copyright (C) 2016 Francois Cuvelier <cuvelier@math.univ-paris13.fr>\n%

DEFAULT_TAG=0.0.13
ifeq ("$(TAG)","")
TAG=$(DEFAULT_TAG)
endif

TAGTIMEcmd := git log --tags --simplify-by-decoration --pretty="format:%ci %d" |grep -E "($(TAG),|$(TAG)\))" |awk '{print $$1,$$2,$$3 }'
TAGTIME := $(shell $(TAGTIMEcmd) )

CURRENT_DIR = $(shell pwd)
DESTDIR=distrib/$(VERSION)

# For archive temporary directory
FILENAME=fc-tools
OCTAVE_PKG=fc-tools

VERSION=$(TAG)
MATLAB_NAME=m$(FILENAME)
OCTAVE_NAME=o$(FILENAME)

OFILENAME := $(OCTAVE_NAME)-$(VERSION)
MFILENAME := $(MATLAB_NAME)-$(VERSION)
OCTAVE_PKG_VERSION := $(OCTAVE_PKG)-$(VERSION)

OCTAVE_INST_MOVE= +fcTools 

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
	@mkdir -p $(DESTDIR)
	@(mv -f $(tmpdir)/$(MFILENAME).7z $(tmpdir)/$(MFILENAME).tar.gz $(tmpdir)/$(MFILENAME).zip $(DESTDIR))
	@rm -fr $(tmpdir)
	@echo "\nCreating files\n  -> $(MFILENAME).tar.gz,\n  -> $(MFILENAME).zip,\n  -> $(MFILENAME).7z"
	@echo "in directory $(DESTDIR)\n"
	
octavetar : setversion GITCOMMIT setcopyright
	@python3 extractfiles.py octave.list > octave.tmp
	@echo "\nCreating files $(OFILENAME).tar.gz, $(OFILENAME).zip and $(OFILENAME).7z and size files ...\n"
	@$(eval tmpdir := $(shell mktemp -d))
	@echo "Building in temprary directoru : $(tmpdir)"
	@tar  -zhcf $(tmpdir)/octavetmp.tar.gz -T octave.tmp
	@(mkdir -p $(tmpdir)/$(OFILENAME))
	@(tar zxf $(tmpdir)/octavetmp.tar.gz -C $(tmpdir)/$(OFILENAME))
	@(cd $(tmpdir) && tar zcf $(OFILENAME).tar.gz $(OFILENAME))
	@mkdir -p $(DESTDIR)
	@(cd $(tmpdir) && zip --symlinks -r $(OFILENAME).zip $(OFILENAME))
	@(cd $(tmpdir) && 7z a $(OFILENAME).7z $(OFILENAME))
	@(cd $(tmpdir)/$(OFILENAME) && mkdir -p inst; mv $(OCTAVE_INST_MOVE) inst/ )
	@(cd $(tmpdir) && mv $(OFILENAME) $(OCTAVE_PKG))
	@(cd $(tmpdir) && tar zcvf $(OCTAVE_PKG_VERSION).tar.gz $(OCTAVE_PKG))
	@(mv -f $(tmpdir)/$(OFILENAME).7z $(tmpdir)/$(OCTAVE_PKG_VERSION).tar.gz $(tmpdir)/$(OFILENAME).tar.gz $(tmpdir)/$(OFILENAME).zip $(DESTDIR))
	@echo "Cleaning"
	@rm -fr $(tmpdir) octave.tmp 
	@echo "\nCreating files\n  -> $(OCTAVE_PKG_VERSION).tar.gz,\n  -> $(OFILENAME).tar.gz,\n  -> $(OFILENAME).zip,\n  -> $(OFILENAME).7z"
	@echo "in directory $(DESTDIR)\n"
	
setversion:
	@echo "Set version to $(TAG)"
	$(shell sed -i "s/v='.*';/v='$(TAG)';/g" +fcTools/version.m)
	$(shell sed -i "s/Version:.*/Version: $(TAG)/g" DESCRIPTION)
	$(shell sed -i "s/Date:.*/Date: $(TAGTIME)/g" DESCRIPTION)

setcopyright:
ifneq ("$(SETCOPYRIGHT)","")
	@echo "Set copyright to :\n$(SETCOPYRIGHT)\n"
	@$(eval filelist:= $(shell find . -name "*.m"))
	@sed -i "s/% <COPYRIGHT>*/$(SETCOPYRIGHT)/" $(filelist)
endif

SEP="***************************************************"

archives: archives_matlab archives_octave

archives_matlab : 
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
	@echo "***2) make MATLAB archives"
	@echo $(SEP)
	@(cd $(tmpdir)/$(FILENAME) && make TAG=$(TAG) SETCOPYRIGHT="$(MCOPYRIGHT)" matlabtar)
	@echo $(SEP)
	@echo "***3) transfert archives to $(DESTDIR)"
	@echo $(SEP)
	@(rsync -av $(tmpdir)/$(FILENAME)/$(DESTDIR)/* $(DESTDIR))
	@rm -fr $(tmpdir)
	
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
	@echo "***3) transfert archives to $(DESTDIR)"
	@echo $(SEP)
	@(rsync -av $(tmpdir)/$(FILENAME)/$(DESTDIR)/* $(DESTDIR))
	@rm -fr $(tmpdir)

	
macoui:
	rsync -av distrib/$(VERSION) macoui:~/public_html/software/codes/fc-tools/

GITCOMMIT :
	@echo "Build GITCOMMIT file"
	@git config --get remote.origin.url > GITCOMMIT
	@git rev-parse HEAD >> GITCOMMIT
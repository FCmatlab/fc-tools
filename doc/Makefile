# DON'T CHANGE THIS FILE if not in  fc-tools package
#   automaticaly updated from fc-tools package with update_package command
#   
HOSTNAME := $(shell hostname -s )
USERNAME := $(shell whoami )
DOC_CURRENT_DIR = $(shell pwd)

# automaticaly created with buildtex_python
ifeq ("$(wildcard special/makefile.auto)","")
message:
	@echo "Not yet configured."
	@echo "  Use ./builtex_python :"
	@echo "    ./builtex_octave -v 5.1.0 
	
else
include special/makefile.auto

BASE=fc-$(PACKAGENAME)
GITBIBLIOREMOTE=ssh://lagagit/MCS/CJS/biblio

# makefile.mod can be used to specify some variables ... for example to set BIBTEX=
ifneq ("$(wildcard makefile.mod)","")  
include makefile.mod
endif




$(BASE).pdf: $(BASE).tex special/biblio.bib special/before.m
	@echo "### $@"
	@echo "***[<BASE>.pdf] Building $(BASE).pdf/ pdflatex process (1/3)"
	$(eval start=$(shell date +%s) )
	$(PDFLATEX) $(BASE)
	$(eval end=$(shell date +%s) )
	$(eval runtime=$(shell echo "scale=2;($(end) - $(start))/60" | bc ))
	@echo "Running in $(runtime) minutes"
	@echo '\\renewcommand{\\fcompilingtime}{'$(runtime)'}' > special/compilingtime.tex
	$(eval CITATION=$(shell grep citation $(BASE).aux))
ifneq ("$(BIBTEX)","")
	@echo "***[<BASE>.pdf] Building $(BASE).pdf/ running bibtex "
	$(BIBTEX) $(BASE)
endif
ifneq ("$(wildcard $(BASE).sagetex.sage)","")
	@echo "***[<BASE>.pdf] Building $(BASE).pdf/ running sage "
	$(SAGE) $(BASE).sagetex.sage
endif
	@echo "***[<BASE>.pdf] Building $(BASE).pdf/ pdflatex process (2/3)"
	$(PDFLATEX) $(BASE)
	@echo "***[<BASE>.pdf] Building $(BASE).pdf/ pdflatex process (3/3)"
	$(PDFLATEX) $(BASE)
	@echo "***[<BASE>.pdf] Building $(BASE).pdf *** END"


special/biblio.bib:
	@(git archive --remote=ssh://lagagit/MCS/CJS/biblio master biblio.bib | tar -x)
	@mv biblio.bib special/
	@chmod 444 special/biblio.bib
	@echo "Writing file special/gitbiblio.tex"
	$(eval GITBIBLIOCOMMIT=$(shell git ls-remote $(GITBIBLIOREMOTE) | grep HEAD | awk -F' ' '{print $$1}'))
	@echo "  -> commit: $(GITBIBLIOCOMMIT)"
	@echo "  -> remote: $(GITBIBLIOREMOTE)"
	@echo '\def\\gitbibliocommit{'$(GITBIBLIOCOMMIT)'}'> special/gitbiblio.tex
	@echo '\def\\gitbilioremote{'$(GITBIBLIOREMOTE)'}'>> special/gitbiblio.tex
	
special/before.m:
	@echo "[Makefile] Writing special/before.m"
ifneq ("$(wildcard fc_$(PACKAGENAME)_set.m)","")
	@echo "fc_$(PACKAGENAME)_set" > special/before.m
else
	@echo "  -> fc_$(PACKAGENAME)_set.m not found! Force to ..!"
	@echo "addpath .." > special/before.m
endif	
	@echo "fc_$(PACKAGENAME).init('verbose',0)" >> special/before.m
ifneq ("$(DEBUG)","")
	@echo "small=true;" >> special/before.m
endif
	@echo "SaveOptions={'format','png', 'dir','./figures','tag',true};" >> special/before.m

endif # ifneq ("$(wildcard special/makefile.auto)","") 

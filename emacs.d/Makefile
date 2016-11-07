modes := $(filter-out $(wildcard *~), $(wildcard modes/*))
elpa  := $(filter-out $(wildcard *~), $(wildcard elpa/*))
pwd   := $(shell pwd)

.PHONY: install
install: $(modes) $(elpa)
	@echo Symlinking Emacs Modes...
	@mkdir -p $(emacsdir)/modes
	@for FILE in $(modes); do \
	    ln -vsf $(pwd)/$$FILE $(emacsdir)/$$FILE; \
	done
	@echo Symlinking Emacs Lisp Package Archive...
	@mkdir -p $(emacsdir)/elpa
	@for FILE in $(elpa); do \
	    ln -vsf $(pwd)/$$FILE $(emacsdir)/$$FILE; \
	done


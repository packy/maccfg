srcdir   := $(shell pwd)
binfiles := $(filter-out Makefile Makefile~, $(wildcard *))

.PHONY: install
install: $(binfiles)
	@echo Symlinking binfiles...
	@for FILE in $(binfiles); do \
	    ln -vsf $(srcdir)/$$FILE $(bindir)/$$FILE; \
	done

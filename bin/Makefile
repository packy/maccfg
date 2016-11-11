srcdir   := $(shell pwd)
bindir   := $(HOME)/bin
binfiles := $(filter-out Makefile $(wildcard *~), $(wildcard *))

.PHONY: install
install: $(binfiles)
	@echo Symlinking binfiles...
	@for FILE in $(binfiles); do \
	    ln -vsf $(srcdir)/$$FILE $(bindir)/$$FILE; \
	done

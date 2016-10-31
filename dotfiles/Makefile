srcdir   := $(shell pwd)
dotfiles := $(filter-out Makefile $(wildcard *~), $(wildcard *))

.PHONY: install
install: $(dotfiles)
	@echo Symlinking dotfiles...
	@for FILE in $(dotfiles); do \
	    ln -vsf $(srcdir)/$$FILE $(HOME)/.$$FILE; \
	done

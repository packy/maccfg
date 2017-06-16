srcdir   := $(shell pwd)
dotfiles := $(filter-out Makefile $(wildcard *~), $(wildcard *))

.PHONY: install
install: $(dotfiles)
	@echo Symlinking dotfiles...
	@find $(HOME) -depth 1 -prune -type l ! -exec test -e {} \; -exec rm {} \;
	@for FILE in $(dotfiles); do \
	    ln -vsf $(srcdir)/$$FILE $(HOME)/.$$FILE; \
	done

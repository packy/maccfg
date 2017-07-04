srcdir   := $(shell pwd)
dotfiles := $(filter-out Makefile $(wildcard *~), $(wildcard *))

.PHONY: install
install: $(dotfiles)
	@echo Symlinking bashrc.d
	@ln -vsf $(srcdir) $(HOME)/.bashrc.d

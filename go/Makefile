srcdir   := $(shell pwd)
bindir   := $(HOME)/bin
binfiles := $(filter-out $(wildcard bin/*~), $(wildcard bin/*))

.PHONY: install
install: $(srcdir)/bin/go
	@echo Symlinking bin/go...
	@ln -vsf $(srcdir)/bin/go $(bindir)/go

$(emacsdir)/elpa:
	mkdir -p $(emacsdir)/elpa
	touch $(pwd)/elpa/*

$(emacsdir)/elpa/%: $(pwd)/elpa/%
	@echo Symlinking Emacs Lisp Package Archive...
	ln -vfs $(pwd)/elpa/$* $(emacsdir)/elpa/

$(emacsdir)/modes:
	mkdir -p $(emacsdir)/modes
	touch $(pwd)/modes/*

$(emacsdir)/modes/%: $(pwd)/modes/%
	@echo Symlinking Emacs Modes...
	ln -vfs $(pwd)/modes/$* $(emacsdir)/modes/$*

emacsfiles: $(emacsdir)/elpa \
            $(emacsdir)/elpa/archives \
            $(emacsdir)/elpa/minimap-1.2 \
            $(emacsdir)/modes \
            $(emacsdir)/modes/fill-column-indicator.el \
            $(emacsdir)/modes/php-mode.el \
            $(emacsdir)/modes/cperl-mode.el

install: emacsfiles

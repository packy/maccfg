DEPDIR := .d
$(shell ./make_dependencies $(DEPDIR) )
gitdir := $(HOME)/git
emacsdir := $(HOME)/.emacs.d
bindir := $(HOME)/bin
PERLBREW := $(HOME)/perl5/perlbrew/bin/perlbrew
pwd := $(shell pwd)

all: dotfiles binfiles homebrewed perlbrew git-repos emacsfiles

git-repos: $(DEPDIR)/File-Next ${bindir}/ack #${gitdir}/z

${gitdir}/ack2:
	git clone https://github.com/packy/ack2.git ${gitdir}/ack2

${gitdir}/ack2/Makefile: $(DEPDIR)/homebrew $(PERLBREW) $(DEPDIR)/File-Next
	cd ${gitdir}/ack2; perl Makefile.PL;

${gitdir}/ack2/ack-standalone: ${gitdir}/ack2/Makefile
	cd ${gitdir}/ack2; make ack-standalone
	touch ${gitdir}/ack2/ack-standalone

${bindir}/ack: ${gitdir}/ack2/ack-standalone
	ln -fs ${gitdir}/ack2/ack-standalone ${bindir}/ack
	touch ${bindir}/ack

${gitdir}/file-next:
	git clone https://github.com/petdance/file-next.git ${gitdir}/file-next

$(DEPDIR)/File-Next:
	cd ${gitdir}/file-next; perl Makefile.PL; make install

${gitdir}/z:
	git clone https://github.com/rupa/z.git ${gitdir}/z

$(HOME)/%: dot%
	@perl -e '(my $$source = "$@") =~ s{^.*/([^/]+)$$}{${pwd}/dot$$1}; printf "symlinking %s to %s\n", $$source, "$@"; unlink "$@"; symlink $$source, "$@";'

$(bindir)/%: $(pwd)/bin/%
	ln -fs $(pwd)/bin/$* $(bindir)/$*

$(emacsdir)/elpa:
	mkdir -p $(emacsdir)/elpa
	touch $(pwd)/emacs.d/elpa/*

$(emacsdir)/elpa/%: $(pwd)/emacs.d/elpa/%
	rm -rf $(emacsdir)/elpa/$*; \
	ln -fs $(pwd)/emacs.d/elpa/$* $(emacsdir)/elpa/

$(emacsdir)/modes:
	mkdir -p $(emacsdir)/modes
	touch $(pwd)/emacs.d/modes/*

$(emacsdir)/modes/%: $(pwd)/emacs.d/modes/%
	ln -fs $(pwd)/emacs.d/modes/$* $(emacsdir)/modes/$*

emacsfiles: $(emacsdir)/elpa \
            $(emacsdir)/elpa/archives \
            $(emacsdir)/elpa/minimap-1.2 \
            $(emacsdir)/modes \
            $(emacsdir)/modes/fill-column-indicator.el \
            $(emacsdir)/modes/php-mode.el \
            $(emacsdir)/modes/cperl-mode.el

binfiles: $(bindir)/git-ack \
	  $(bindir)/git-tracks \
	  $(bindir)/sleep-toucher \
	  $(bindir)/xemacs-start-server \
	  $(bindir)/git-autofix \
	  $(bindir)/go \
	  $(bindir)/get_emacs_center_elisp \
	  $(bindir)/xemacs \
	  $(bindir)/xemacs-wait

dotfiles: $(HOME)/.ackrc \
          $(HOME)/.bash_ack \
          $(HOME)/.bash_aliases \
          $(HOME)/.bash_functions \
          $(HOME)/.bash_git \
          $(HOME)/.bash_login \
          $(HOME)/.bash_ls \
          $(HOME)/.bash_path_functions \
          $(HOME)/.bash_perforce \
          $(HOME)/.bash_perforce_functions \
          $(HOME)/.bash_profile \
          $(HOME)/.bashrc \
          $(HOME)/.darwinrc \
          $(HOME)/.emacs \
          $(HOME)/.gitconfig \
          $(HOME)/.gitignore

perlbrew:
	@${gitdir}/maccfg/install_perlbrew ${PERLBREW}

HOMEBREWED = bash fpp pcre git libpng node switchaudio-osx xz coreutils freetype icu4c mysql openssl homebrew/php/php70 unixodbc findutils gettext jpeg nmap p7zip readline wget

.ONESHELL:
homebrewed:
	@${gitdir}/maccfg/install_homebrew
	@for PKG in $(HOMEBREWED); do \
	    FILE=$(echo homebrew-$$PKG | sed -e '/-.*\/-/g') ;\
	    if [[ ! -e $(DEPDIR)/$$FILE ]]; then \
		brew install $$PKG ;\
	    fi ;\
	done

emacs:
	if [[ ! -e $(DEPDIR)/homebrew-emacs ]]; then \
	    brew install emacs --with-cocca
	done

git: USE_LIBPCRE=yes
git: homebrew pcre 

bash: /etc/shells
	@if ! grep -q "/usr/local/bin/bash" /etc/shells; then echo "Please add /usr/local/bin/bash to /etc/shells"; fi

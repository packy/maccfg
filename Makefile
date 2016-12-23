export emacsdir := $(HOME)/.emacs.d
export gitdir   := $(HOME)/git
export bindir   := $(HOME)/bin

DEPDIR := .d
$(shell ./make_dependencies $(DEPDIR) )

PERLBREW := $(HOME)/perl5/perlbrew/bin/perlbrew
pwd := $(shell pwd)

all:  homebrewed perlbrew ack emacsfiles install

include ack2.mk

${gitdir}/z:
	git clone https://github.com/rupa/z.git ${gitdir}/z

perlbrew:
	@${gitdir}/maccfg/perlbrew/install ${PERLBREW}

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
	@if ! grep -q "/usr/local/bin/bash" /etc/shells; then \
	    echo "Adding /usr/local/bin/bash to /etc/shells"; \
	    echo "/usr/local/bin/bash" | sudo tee -a /etc/shells; \
	fi

.PHONY: install
install: ack
	@cd dotfiles && $(MAKE)
	@cd bin      && $(MAKE)
	@cd emacs.d  && $(MAKE)
	@ln -vfs ${gitdir}/ack2/ack-standalone ${bindir}/ack; touch ${bindir}/ack


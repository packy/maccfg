export emacsdir := $(HOME)/.emacs.d
export gitdir   := $(HOME)/git
export bindir   := $(HOME)/bin
export cfgdir   := $(HOME)/git/maccfg

DEPDIR := .d
$(shell ./make_dependencies $(DEPDIR) )

PERLBREW := $(HOME)/perl5/perlbrew/bin/perlbrew
pwd := $(shell pwd)

all:  homebrewed perlbrew ack emacsfiles install

include ack2.mk

${gitdir}/z:
	git clone https://github.com/rupa/z.git ${gitdir}/z

recent:
	source ${cfgdir}/bashrc.d/enabled/Dock.sh; add-recent-applications-to-dock

perlbrew:
	@${cfgdir}/perlbrew/install ${PERLBREW}

HOMEBREWED = bash fpp pcre git libpng node switchaudio-osx xz coreutils freetype icu4c mysql openssl homebrew/php/php70 unixodbc findutils gettext jpeg nmap p7zip readline wget

.ONESHELL:
homebrewed:
	@${cfgdir}/homebrew/install
	@cd ${cfgdir}/homebrew; make

git: USE_LIBPCRE=yes
git: homebrew pcre

$(HOMEBREW_PREFIX)/bin/ansi:
	cd $(HOMEBREW_PREFIX)/bin; curl -OL git.io/ansi; chmod 755 ansi

bash: /etc/shells
	@if ! grep -q "$(HOMEBREW_PREFIX)/bin/bash" /etc/shells; then \
	    echo "Adding $(HOMEBREW_PREFIX)/bin/bash to /etc/shells"; \
	    echo "$(HOMEBREW_PREFIX)/bin/bash" | sudo tee -a /etc/shells; \
	fi

.PHONY: install
install: ack
	@ln -fs ${gitdir}/bashrc.d $(HOME)/.bashrc.d
	@cd dotfiles && $(MAKE)
	@cd bin      && $(MAKE)
	@cd emacs.d  && $(MAKE)
	@ln -vfs ${gitdir}/ack2/ack-standalone ${bindir}/ack; touch ${bindir}/ack

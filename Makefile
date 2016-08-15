gitdir := $(HOME)/git
pwd := $(shell pwd)

all: git-repos dotfiles homebrewed perlbrew

git-repos: ${gitdir}/ack2 ${gitdir}/file-next ${gitdir}/z

${gitdir}/ack2:
	git clone https://github.com/packy/ack2.git ${gitdir}/ack2; \
	cd ${gitdir}/ack2; \
	perl Makefile.PL; \
	make ack-standalone; \
	ln -s ${gitdir}/ack2/ack-standalone $(HOME)/bin/ack; \
	ln -s ${pwd}/dot.ackrc $(HOME)/.ackrc

${gitdir}/file-next:
	git clone https://github.com/petdance/file-next.git ${gitdir}/file-next

${gitdir}/z:
	git clone https://github.com/rupa/z.git ${gitdir}/z

$(HOME)/%: dot%
	perl -e '(my $$source = "$@") =~ s{^.*/([^/]+)$$}{${pwd}/dot$$1}; symlink $$source, "$@";'

dotfiles: $(HOME)/.ackrc \
          $(HOME)/.bash_ack \
          $(HOME)/.bash_aliases \
          $(HOME)/.bash_functions \
          $(HOME)/.bash_git \
          $(HOME)/.bash_ls \
          $(HOME)/.bash_path_functions \
          $(HOME)/.bash_perforce \
          $(HOME)/.bash_perforce_functions \
          $(HOME)/.bash_prodile \
          $(HOME)/.bashrc \
          $(HOME)/.emacs

perlbrew: $(HOME)/perl5/perlbrew
	curl -L http://install.perlbrew.pl | bash
	perlbrew install stable

HOMEBREWED = bash fpp pcre git libpng node switchaudio-osx xz coreutils freetype icu4c mysql openssl php70 unixodbc findutils gettext jpeg nmap p7zip readline wget

.ONESHELL:
homebrewed: homebrew $(HOMEBREWED)
	for PKG in $(HOMEBREWED); do
	  if [[ "$$(brew --versions $$PKG" = "" ]]; then
	    brew install $$PKG
	  fi
	done

homebrew: /usr/local/bin/brew
	ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

git: USE_LIBPCRE=yes
git: homebrew pcre 

bash: /etc/shells
	@if ! grep -q "/usr/local/bin/bash" /etc/shells; then echo "Please add /usr/local/bin/bash to /etc/shells"; fi

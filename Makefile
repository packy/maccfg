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

$(HOME)/.bash_ack:
	ln -s ${pwd}/dot.bash_ack $(HOME)/.bash_ack

$(HOME)/.bash_aliases:
	ln -s ${pwd}/dot.bash_aliases $(HOME)/.bash_aliases

$(HOME)/.bash_functions:
	ln -s ${pwd}/dot.bash_functions $(HOME)/.bash_functions

$(HOME)/.bash_git:
	ln -s ${pwd}/dot.bash_git $(HOME)/.bash_git

$(HOME)/.bash_ls:
	ln -s ${pwd}/dot.bash_ls $(HOME)/.bash_ls

$(HOME)/.bashrc:
	ln -s ${pwd}/dot.bashrc $(HOME)/.bashrc

$(HOME)/.emacs:
	ln -s ${pwd}/dot.emacs $(HOME)/.emacs

dotfiles: $(HOME)/.bash_ack $(HOME)/.bash_aliases $(HOME)/.bash_functions \
          $(HOME)/.bash_git $(HOME)/.bash_ls $(HOME)/.bashrc $(HOME)/.emacs

homebrewed: homebrew pcre git coreutils findutils

homebrew: /usr/local/bin/brew
	ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

ifeq ($(shell brew ls --versions pcre),)
pcre: homebrew 
	brew install pcre
endif

ifeq ($(shell brew ls --versions git),)
git: USE_LIBPCRE=yes
git: homebrew pcre 
	brew install git
endif

ifeq ($(shell brew ls --versions coreutils),)
coreutils: homebrew 
	brew install coreutils
endif

ifeq ($(shell brew ls --versions findutils),)
findutils: homebrew 
	brew install findutils
endif

perlbrew: $(HOME)/perl5/perlbrew
	curl -L http://install.perlbrew.pl | bash
	perlbrew install stable

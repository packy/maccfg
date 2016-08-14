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

perlbrew: $(HOME)/perl5/perlbrew
	curl -L http://install.perlbrew.pl | bash
	perlbrew install stable

homebrewed: homebrew bash fpp git libpng node pcre switchaudio-osx xz coreutils freetype icu4c mysql openssl php70 unixodbc findutils gettext jpeg nmap p7zip readline wget

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

ifeq ($(shell brew ls --versions switchaudio-osx),)
switchaudio-osx: homebrew 
	brew install switchaudio-osx
endif

ifeq ($(shell brew ls --versions bash),)
bash: homebrew 
	brew install bash
	sudo echo "/usr/local/bin/bash # bash 4.3.42" >> /etc/shells
endif

ifeq ($(shell brew ls --versions node),)
node: homebrew 
	brew install node
endif

ifeq ($(shell brew ls --versions p7zip),)
p7zip: homebrew 
	brew install p7zip
endif

ifeq ($(shell brew ls --versions openssl),)
openssl: homebrew 
	brew install openssl
endif

ifeq ($(shell brew ls --versions fpp),)
fpp: homebrew
	brew install fpp
endif

ifeq ($(shell brew ls --versions freetype),)
freetype: homebrew
	brew install freetype
endif

ifeq ($(shell brew ls --versions gettext),)
gettext: homebrew
	brew install gettext
endif

ifeq ($(shell brew ls --versions icu4c),)
icu4c: homebrew
	brew install icu4c
endif

ifeq ($(shell brew ls --versions jpeg),)
jpeg: homebrew
	brew install jpeg
endif

ifeq ($(shell brew ls --versions libpng),)
libpng: homebrew
	brew install libpng
endif

ifeq ($(shell brew ls --versions mysql),)
mysql: homebrew
	brew install mysql
endif

ifeq ($(shell brew ls --versions nmap),)
nmap: homebrew
	brew install nmap
endif

ifeq ($(shell brew ls --versions php70),)
php70: homebrew
	brew install php70
endif

ifeq ($(shell brew ls --versions readline),)
readline: homebrew
	brew install readline
endif

ifeq ($(shell brew ls --versions unixodbc),)
unixodbc: homebrew
	brew install unixodbc
endif

ifeq ($(shell brew ls --versions wget),)
wget: homebrew
	brew install wget
endif

ifeq ($(shell brew ls --versions xz),)
xz: homebrew
	brew install xz
endif

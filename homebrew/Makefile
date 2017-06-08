$(shell mkdir -p .d)

.PHONY: install
install: homebrew iterm2 keka diff-so-fancy hr screenresolution pcre \
         readline git quicklook

homebrew:         .d/homebrew
apr-util:         .d/apr-util.brew
apr:              .d/apr.brew
bash:             .d/bash.brew
diff-so-fancy:    .d/diff-so-fancy.brew
emacs:            .d/emacs.cask
git:              .d/git.brew
highlight:        .d/highlight.brew
hr:               .d/hr.brew
iterm2:           .d/iterm2.cask
keka:             .d/keka.cask
mysql:            .d/mysql.brew
openssl:          .d/openssl.brew
pcre:             .d/pcre.brew
perl:             .d/perl.brew
readline:         .d/readline.brew
screenresolution: .d/screenresolution.brew
sqlite:           .d/sqlite.brew
subversion:       .d/subversion.brew
virtualbox:       .d/virtualbox.cask
wget:             .d/wget.brew

quicklook: .d/betterzipql.cask .d/quicklook-csv.cask qlcolorcode \
           .d/quicklook-json.cask .d/webpquicklook.cask 

qlcolorcode: highlight .d/qlcolorcode.cask

.d/homebrew:
	@./install

.d/caskroom:
	@./install

.d/%.cask: .d/caskroom
	brew cask install $*
	@./install

.d/%.brew:
	brew install $*
	@./install

sshpass: .d/sshpass.brew
.d/sshpass.brew:
	brew install https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb
	@./install


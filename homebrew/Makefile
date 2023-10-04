$(shell mkdir -p .d)

.PHONY: install
install: homebrew iterm2 keka diff-so-fancy hr screenresolution pcre \
         readline git p7zip quicklook bash highlight mas wget hub \
         sleepwatcher shellcheck font-jetbrains

homebrew:         .d/homebrew
appcleaner:       .d/appcleaner.brew
apr-util:         .d/apr-util.brew
apr:              .d/apr.brew
#atom:             .d/atom.cask
bash:             .d/bash.brew
diff-so-fancy:    .d/diff-so-fancy.brew
disk-inventory-x: .d/disk-inventory-x.brew
emacs:            .d/emacs.cask
font-jetbrains:   .d/font-jetbrains-mono-nerd-font.cask
gimp:             .d/gimp.cask
git:              .d/git.brew
highlight:        .d/highlight.brew
hr:               .d/hr.brew
hub:              .d/hub.brew
iterm2:           .d/iterm2.cask
keka:             .d/keka.cask
mas:              .d/mas.brew
mysql:            .d/mysql.brew
openssl:          .d/openssl.brew
p7zip:            .d/p7zip.brew
xz:               .d/xz.brew
pcre:             .d/pcre.brew
perl:             .d/perl.brew
pyenv:            .d/pyenv.brew
readline:         .d/readline.brew
screenresolution: .d/screenresolution.brew
shellcheck:       .d/shellcheck.brew
sleepwatcher:     .d/sleepwatcher.brew
sqlite:           .d/sqlite.brew
subversion:       .d/subversion.brew
virtualbox:       .d/virtualbox.cask
wget:             .d/wget.brew

quicklook: .d/betterzip.cask .d/quicklook-csv.cask qlcolorcode \
           .d/quicklook-json.cask .d/webpquicklook.cask

qlcolorcode: highlight .d/qlcolorcode.cask

.d/homebrew:
	@./install

.d/caskroom:
	@./install

# .d/atom.cask:
# 	@brew install --cask atom
# 	@apm install sync-settings
# 	@./write_atom_config.pl
# 	@./install
# 	@ln -s /Applications/Atom.app/Contents/Resources/app/atom.sh $HOMEBREW_PREFIX/bin/atom

.d/git.brew: pcre
	@export USE_LIBPCRE=yes; brew install --build-from-source git

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

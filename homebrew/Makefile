.PHONY: install
install: iterm keka diff-so-fancy hr

/usr/local/Caskroom:
	brew tap caskroom/cask

iterm: /Applications/iTerm.app

/Applications/iTerm.app: /usr/local/Caskroom
	brew cask install iterm2

#/usr/local/bin/sshpass: /usr/local/Cellar/sshpass/1.06/bin/sshpass
#	brew install https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb

keka: /Applications/Keka.app

/Applications/Keka.app: /usr/local/Caskroom
	brew cask install keka

diff-so-fancy: /usr/local/bin/diff-so-fancy

/usr/local/bin/diff-so-fancy: /usr/local/Caskroom
	brew install diff-so-fancy

hr: /usr/local/bin/hr

/usr/local/bin/hr: /usr/local/Caskroom
	brew install hr


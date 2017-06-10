.PHONY: install
install: OpenGoogleMail.app OpenGoogleInbox.app OpenGooglePlayMusic.app
	cp -rfv *.app /Applications/

%.app:
	osacompile -o "$*.app" "$*.applescript"


all:
	mkdir -p dist; sbcl --script save-image.lisp

install-linux-chromium:
	mkdir -p ~/.config/chromium/NativeMessagingHosts
	cp com.margaine.pgp_ext_app.json ~/.config/chromium/NativeMessagingHosts/
	cp dist/pgp-ext-app /usr/local/bin

install-linux-chromium-debug:
	mkdir -p ~/.config/chromium/NativeMessagingHosts
	ln -sf $PWD/com.margaine.pgp_ext_app.json ~/.config/chromium/NativeMessagingHosts/
	ln -sf $PWD/dist/pgp-ext-app /usr/local/bin

.PHONY: install-linux-chromium install-linux-chromium-debug

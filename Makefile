all:
	mkdir -p dist; sbcl --script save-image.lisp

install-linux-chromium:
	mkdir -p ~/.config/chromium/NativeMessagingHosts
	cp com.margaine.pgp_ext_app.json ~/.config/chromium/NativeMessagingHosts/
	cp dist/pgp-ext-app /usr/local/bin

CURRENT_DIR = $(shell pwd)

install-linux-chromium-debug:
	mkdir -p ~/.config/chromium/NativeMessagingHosts
	ln -sf $(CURRENT_DIR)/com.margaine.pgp_ext_app.json ~/.config/chromium/NativeMessagingHosts/
	ln -sf $(CURRENT_DIR)/dist/pgp-ext-app /usr/local/bin

.PHONY: install-linux-chromium install-linux-chromium-debug

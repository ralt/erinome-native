# erinome-native

The native application to use with https://github.com/Ralt/erinome

## How to install

Linux x86_64 and Chromium supported for now.

```
$ wget https://github.com/Ralt/erinome-native/releases/download/0.0.2/erinome-native.zip
$ unzip erinome-native.zip
$ cd erinome-native/
$ sudo make install-linux-chromium
```

## Roadmap before release

- [x] Refactor to create and use define-action
- [ ] Find a way to build on multiple platforms
- [x] Find out how to handle releases. Github releases.
- [x] Handle errors
- [ ] Extract some code into a `chrome-native-messaging` package (and
  push it on quicklisp)
  - [x] Extract
  - [ ] Push on quicklisp

## License

MIT

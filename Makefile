

install:
	yarn

build:
	npx parcel build --experimental-scope-hoisting src/index.html

dev:
	npx parcel watch src/index.html

upgrade:
	yarn upgrade --latest

clean:
	rm -rf dist

reinstall:
	rm -rf node_modules
	rm -rf elm-stuff
	yarn

lint:
	npx elm-analyse
	npx elm-format --validate src/
	npx stylelint src/**.scss

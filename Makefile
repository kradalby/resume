

install:
	yarn

build:
	npx parcel build --public-url "./" --no-scope-hoist src/index.html

dev:
	npx parcel serve src/index.html

upgrade:
	yarn upgrade --latest

clean:
	rm -rf dist

clean-all: clean
	rm -rf node_modules .cache .parcel-cache

reinstall:
	rm -rf node_modules
	rm -rf elm-stuff
	yarn

lint:
	npx elm-analyse
	npx elm-format --validate src/
	npx stylelint src/**.scss

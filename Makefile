.PHONY: convert build

convert:
	rm -rf out
	mkdir out
	fd . in -x ./go.sh

build:
	./generate-html.sh

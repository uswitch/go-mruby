MRUBY_COMMIT ?= 1.2.0

all: test

clean:
	rm -rf vendor
	rm -f libmruby.a

gofmt:
	@echo "Checking code with gofmt.."
	gofmt -s *.go >/dev/null

lint:
	sh golint.sh

lib: mruby-build.rb build.sh
	./build.sh
	docker run -it -v "$(shell pwd):/mnt/go-mruby" debian:jessie \
		/bin/sh -c "apt-get update && apt-get install -y git ruby gcc bison flex make && cd /mnt/go-mruby && ./build.sh"

test: gofmt lint
	go test -v

.PHONY: all clean lib test lint

all: test
.PHONY: all test clean

PKG=mocks

bin/test: $(shell find ${PKG} .deps -name *.pony) $(shell find test .deps -name *.pony) 
	stable env ponyc -o bin test

#
# Examples:
#   make test tests='"prefix"'
#     run the pony tests, filtering for only those whos name starts with "prefix"
test: bin/test
	$^ --only=$(tests)

bin/test: 
	mkdir -p bin
	ponyc --debug -o bin test

clean:
	rm -rf bin


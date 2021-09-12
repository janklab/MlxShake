# This Makefile lets you build the project and its documentation, run tests,
# package it for distribution, and so on.
#
# This is mostly provided just as a convenience for developers who like using 'make'.
# All the actual build logic is in the dev-kit/*.m files, which can be run
# directly, without using 'make'. The exception is 'make java', which must be
# run without Matlab running, because Matlab locks the JAR files it has loaded.
#
# Targets provided:
#
#   make docs    - Build the Markdown-stage doco in docs/
#   make doc     - Build the final static doco into doc/
#
#   make test    - Run the project Matlab unit tests
#
#   make dist    - Build all the project distribution files
#   make toolbox - Build the project distribution Matlab Toolbox .mltbx file
#   make zips    - Build the project distribution zip files
#
#   make java    - Build your custom Java code in src/ and install it into lib/
#   make doc-src - Build derived Markdown files in docs/
#   make clean   - Remove derived files

.PHONY: test
test:
	./dev-kit/run_matlab "exportmlx_make test"

.PHONY: build
build:
	./dev-kit/run_matlab "exportmlx_make build"

# Build the programmatically-generated parts of the _source_ files for the doco
.PHONY: docs
docs:
	./dev-kit/run_matlab "exportmlx_make docs"

# Build the actual output documents
.PHONY: doc
doc:
	./dev-kit/run_matlab "exportmlx_make doc"

.PHONY: m-doc
m-doc:
	./dev-kit/run_matlab "exportmlx_make m-doc"

.PHONY: toolbox
toolbox: m-doc
	./dev-kit/run_matlab "exportmlx_make toolbox"

.PHONY: dist
dist:
	./dev-kit/run_matlab "exportmlx_make dist"

# TODO: Port this to M-code. This is hard because the .jar cannot be copied in to place
# in lib while Matlab is running, because it locks loaded .jar files (at least on Windows).
.PHONY: java
java:
	cd src/java/ExportMlx-java; mvn package
	mkdir -p lib/java/ExportMlx-java
	cp src/java/ExportMlx-java/target/*.jar lib/java/ExportMlx-java

.PHONY: clean
clean:
	./dev-kit/run_matlab "exportmlx_make clean"

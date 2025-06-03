AS = clang
DBG = lldb
LD = ld
XCRUN = xcrun

.PHONY: build-file
build-file: build-dir
	@if [ -z "$(FILE)" ]; then echo "Error: FILE variable is not set. Usage: make build-file FILE=path/to/your/file.s"; exit 1; fi
	$(eval OBJ_NAME := $(notdir $(basename $(FILE))))
	$(AS) -Wall -g -o build/$(OBJ_NAME).o -c $(FILE)
	$(LD) -o build/$(OBJ_NAME) build/$(OBJ_NAME).o -lSystem -syslibroot `$(XCRUN) -sdk macosx --show-sdk-path`

.PHONY: check
check:
	@arch | grep -q arm64 && echo "SUCCESS: Running on arm64" || echo "ERROR: Running on non-arm64"
	@which $(AS) > /dev/null && echo "SUCCESS: $(AS) is installed" || echo "ERROR: $(AS) not found, please install clang"
	@which $(LD) > /dev/null && echo "SUCCESS: $(LD) is installed" || echo "ERROR: $(LD) not found, please install clang"
	@which $(DBG) > /dev/null && echo "SUCCESS: $(DBG) is installed" || echo "ERROR: $(DBG) not found, please install lldb"
	@which $(XCRUN) > /dev/null && echo "SUCCESS: $(XCRUN) is installed" || echo "ERROR: $(XCRUN) not found, please install Xcode Command Line Tools"

.PHONY: build-dir
build-dir:
	if [ ! -d build ]; then mkdir build; fi

.PHONY: run
run: build-file
	./build/$(OBJ_NAME)

.PHONY: debug
debug: build-file
	$(DBG) ./build/$(OBJ_NAME)

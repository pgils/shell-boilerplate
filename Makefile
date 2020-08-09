OUTPUT      ?= boilerplate.sh
SPP         ?= ./spp.sh
SHELLCHECK  ?= shellcheck --enable=all --severity=style
SHELLS       = sh bash

.PHONY: $(SHELLS) check clean

$(SHELLS):
	TARGETSHELL=$@ $(SPP) boilerplate.sh.in > $(OUTPUT)

check: $(SHELLS:=-check) clean
%-check: %
	$(SHELLCHECK) $(OUTPUT)

clean:
	rm -rf $(OUTPUT)

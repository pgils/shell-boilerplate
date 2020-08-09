OUTPUT ?= boilerplate.sh
SPP ?= ./spp.sh
SHELLCHECK ?= shellcheck
SHELLS = sh bash

.PHONY: $(SHELLS) check clean

$(SHELLS):
	SHELL=$@ $(SPP) boilerplate.sh.in > $(OUTPUT)

check: $(SHELLS:=-check) clean
%-check: %
	$(SHELLCHECK) $(OUTPUT)

clean:
	rm -rf $(OUTPUT)

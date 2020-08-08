OUTPUT ?= boilerplate.sh
SPP ?= ./spp.sh
SHELLCHECK ?= shellcheck

sh:
	$(SPP) boilerplate.sh.in > $(OUTPUT)

sh-check: sh
	$(SHELLCHECK) $(OUTPUT)

bash:
	BASHSHELL=1 $(SPP) boilerplate.sh.in > $(OUTPUT)

bash-check: bash
	$(SHELLCHECK) $(OUTPUT)

check: sh-check bash-check clean

clean:
	rm -rf $(OUTPUT)
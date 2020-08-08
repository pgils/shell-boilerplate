OUTPUT ?= boilerplate.sh
SPP ?= ./spp.sh
SHELLCHECK ?= shellcheck

sh:
	$(DEF) $(SPP) boilerplate.sh.in > $(OUTPUT)

sh-check: sh
	$(SHELLCHECK) $(OUTPUT)

bash: DEF = BASHSHELL=1
bash: sh

bash-check: bash
	$(SHELLCHECK) $(OUTPUT)

check: sh-check bash-check clean

clean:
	rm -rf $(OUTPUT)
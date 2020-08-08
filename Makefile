OUTPUT ?= boilerplate.sh
SPP ?= ./spp.sh

all:
	$(SPP) boilerplate.sh.in > $(OUTPUT)

bash:
	BASHSHELL=1 $(SPP) boilerplate.sh.in > $(OUTPUT)

clean:
	rm -rf $(OUTPUT)
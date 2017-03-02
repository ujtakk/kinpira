VERBOSE   = 0
SIMULATOR = iverilog
MODULE    = renkon_top.v.erb
TARGET    = test/test_$(MODULE)
INCLUDE   = $(shell git rev-parse --show-toplevel)/rtl/ninjin

LINK_DIR  = .
DIST      = ../dist

include Makefile.dep
include ../../utils/VERBMakefile

.PHONY: file test clean log edit diff

file: $(TARGET:.v.erb=.com)
test: $(TARGET:.v.erb=.log)

clean: clean-common

log:
	@nvim $(TARGET:.v.erb=.log)

com:
	@nvim $(TARGET:.v.erb=.com)

edit:
	@nvim -O $(TARGET) $(MODULE)

diff:
	@nvim -d ../../data/renkon/output_$(shell echo $(MODULE) | cut -d. -f1).dat \
           ../../data/renkon/true_$(shell echo $(MODULE) | cut -d. -f1).dat

define DEP_IN
## -*- text -*-
## ignore list

ignore_file {
}

ignore_com {
}
endef
export DEP_IN

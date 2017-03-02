VERBOSE   = 0
SIMULATOR = iverilog
MODULE    = gobou_top.v.erb
TARGET    = test/test_$(MODULE)
INCLUDE   = $(shell git rev-parse --show-toplevel)/rtl/ninjin

LINK_DIR  = .
DIST      = ../dist

include Makefile.dep
include VERBMakefile

.PHONY: all file test clean log edit diff
file: $(TARGET:.v.erb=.com)
test: $(TARGET:.v.erb=.log)

all:
	make clean
	make test

clean: clean-common

log:
	@vim $(TARGET:.v.erb=.log)

com:
	@nvim $(TARGET:.v.erb=.com)

edit:
	@vim -O $(TARGET) $(MODULE)

diff:
	@vimdiff ../../data/renkon/output_$(shell echo $(MODULE) | cut -d. -f1).dat \
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

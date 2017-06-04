VERBOSE   = 0
SIMULATOR = vsim
MODULE    = renkon_top
TARGET    = test/test_$(MODULE).v.erb
INCLUDE   = $(shell git rev-parse --show-toplevel)/rtl/ninjin

LINK_DIR  = .
DIST      = ../../dist

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
	@nvim -O $(TARGET) $(MODULE).v.erb

diff:
	@nvim -d output_$(MODULE).dat \
		 true_$(MODULE).dat

define DEP_IN
## -*- text -*-
## ignore list

ignore_file {
}

ignore_com {
}
endef
export DEP_IN

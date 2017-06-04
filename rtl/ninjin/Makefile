VERBOSE    = 0
VERBFILES  = $(wildcard *.v.erb)  $(wildcard test/*.v.erb)
VHERBFILES = $(wildcard *.vh.erb) $(wildcard test/*.vh.erb)
VFILES     = $(VERBFILES:.v.erb=.v)
VHFILES    = $(VHERBFILES:.vh.erb=.vh)

LINK_DIR  = .
DIST      = ../../dist

ifeq ($(VERBOSE),1)
  E = @true
  Q =
else
  E = @
  Q = @
endif

ERUBY  = erb -T - $<

.PHONY: dist clean
.SUFFIXES: .v .v.erb .vh .vh.erb

dist:
	$(MAKE) $(VFILES) $(VHFILES)
	mkdir -p $(DIST)
	rsync -L -avz $(VFILES) $(VHFILES) $(DIST)

.v.erb.v:
	$(E) echo "  ERUBY (.v.erb)    $<"
ifeq ($(VERBOSE),1)
	$(Q) $(ERUBY) 2>&1 | tee $@
else
	$(Q) $(ERUBY) > $@ 2>&1
endif

.vh.erb.vh:
	$(E) echo "  ERUBY (.vh.erb)   $<"
ifeq ($(VERBOSE),1)
	$(Q) $(ERUBY) 2>&1 | tee $@
else
	$(Q) $(ERUBY) > $@ 2>&1
endif

clean:
	rm -f *~ test/*~
	rm -f *.com test/*.com
	rm -f *.log test/*.log
	rm -f Makefile.dep
	rm -f dep.in

	### vsim
	rm -f vsim.wlf transcript
	rm -f vish_stacktrace.vstf
	rm -rf work csrc

	### xsim
	rm -rf xsim.dir
	rm -f *.jou *.pb
	rm -f *.wdb

	### vcs
	rm -f default.cfg vcdplus.vpd vcs.key
	rm -rf *.daidir

	### iverilog
	rm -f *.out test/*.out

	rm -f $(VERBFILES:.v.erb=.v)
	rm -f $(VERBFILES:.v.erb=.v.in)
	rm -f $(VHERBFILES:.vh.erb=.vh)
	rm -f $(VINFILES:.v.in=.v)

	rm -f $(LINK_FILES)

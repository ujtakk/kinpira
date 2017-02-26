DIST = ../dist
HEADERS = $(wildcard *.vh.erb)
SOURCES = $(wildcard *.v.erb)

all: $(HEADERS:.vh.erb=.vh) $(SOURCES:.v.erb=.v)

dist: all
	mkdir -p $(DIST)
	cp $(HEADERS:.vh.erb=.vh) $(DIST)
	cp $(SOURCES:.v.erb=.v) $(DIST)

clean:
	rm -f $(HEADERS:.vh.erb=.vh)
	rm -f $(SOURCES:.v.erb=.v)

.SUFFIXES: .v .v.erb .vh .vh.erb

ERUBY=erb -T -

.v.erb.v:
	@echo "  ERUBY (.v.erb)    $<"
	@(rm -f $@ ; $(ERUBY) $< > $@ || (rm -f $@ ; false))
	@chmod 444 $@

.vh.erb.vh:
	@echo "  ERUBY (.vh.erb)   $<"
	@(rm -f $@ ; $(ERUBY) $< > $@ || (rm -f $@ ; false))
	@chmod 444 $@

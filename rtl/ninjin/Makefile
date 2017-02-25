all:
	for i in *.v.erb; do \
		erb -T - $$i > `echo $$i | awk -F . '{print $$1 "." $$2}'`; \
	done
	for i in *.vh.erb; do \
		erb -T - $$i > `echo $$i | awk -F . '{print $$1 "." $$2}'`; \
	done

dist:
	mkdir -p ../dist
	cp *.v *.vh ../dist

clean:
	rm -f *.v

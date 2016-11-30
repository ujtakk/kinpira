all:
	for i in *.v.erb; do \
		erb -T - $$i > `echo $$i | awk -F . '{print $$1 "." $$2}'`; \
	done
	for i in *.vh.erb; do \
		erb -T - $$i > `echo $$i | awk -F . '{print $$1 "." $$2}'`; \
	done
	cp *.v *.vh ../src

dist:
	cp ../../../gobou/dist/*.v ../../../gobou/dist/*.vh ../src
	cp ../../../renkon/dist/*.v ../../../renkon/dist/*.vh ../src

clean:
	rm -f *.v

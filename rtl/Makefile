.PHONY: dist clean

dist:
	sed -i -e "s/$$dist = false/$$dist = true/g" ninjin/ninjin.rb
	(cd renkon; make dist)
	(cd gobou; make dist)
	(cd ninjin; make dist)
	sed -i -e "s/$$dist = true/$$dist = false/g" ninjin/ninjin.rb

full:
	rsync -av dist/ ../ip_repo/kinpira_1.0/src/

lite:
	rsync -av dist/ ../ip_repo/kinpira_lite_1.0/src/

test: dist
	rsync -av dist/ ../ip_repo/test_1.0/src/

clean:
	(cd renkon; make clean)
	(cd gobou; make clean)
	(cd ninjin; make clean)

all: slink

slink:
	nim compile -d:release --out:slink slink.nim
install:
	mkdir -p $(DESTDIR)/bin
	mv slink $(DESTDIR)/bin
	chmod a+x $(DESTDIR)/bin/slink
publish:
	rm *.snap || :
	snapcraft clean
	snapcraft
	snapcraft push *.snap --release stable

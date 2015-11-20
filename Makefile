all: bin/32/slink bin/64/slink

bin/64/slink:
	mkdir -p bin/64
	nim compile -d:release --out:bin/64/slink slink.nim

bin/32/slink:
	# requires libc6-dev-i386
	mkdir -p bin/32
	nim compile -d:release --passC:-m32 --passL:-m32 --cpu:i386 --out:bin/32/slink slink.nim

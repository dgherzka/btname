CFLAGS = -Wall -Weverything -lobjc -framework IOBluetooth

build: btname

install: build
	install -m 755 btname /usr/local/bin/btname

uninstall:
	${RM} /usr/local/bin/btname

clean:
	${RM} btname

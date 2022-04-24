PRE = /usr/bin
CWHOME = /usr/share/cwmanager
 
install:
	mkdir -p $(CWHOME)/widgets
	cp ./Makefile $(CWHOME)
	cp -r ./src/gui $(CWHOME)
	cp -r ./src/widgets $(CWHOME)
	install -m 755 ./src/cwmanager.sh $(PRE)/cwmanager
	bash ./genmanpage.sh

uninstall:
	rm -rf $(CWHOME) $(PRE)/cwmanager /usr/share/man/man1/cwmanager.1.gz /usr/share/man/tr/man1/cwmanager.1.gz

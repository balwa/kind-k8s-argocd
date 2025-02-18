.PHONY: setup cleanup clean

setup:
	./setup.sh

cleanup:
	./cleanup.sh

clean:
	make cleanup 
	make setup
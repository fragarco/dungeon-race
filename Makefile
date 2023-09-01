2DSK:=$$CPCT_PATH/tools/iDSK-0.13/bin/iDSK

MAIN:=./src/main.bas
SOURCE:=./dist/dungeon.bas
TARGET_DSK:=./dist/dungeon.dsk
PYTHON:=python3

all: $(SOURCE)
	$(2DSK) $(TARGET_DSK) -n
	$(2DSK) $(TARGET_DSK) -i $(SOURCE) -t 0

$(SOURCE): $(MAIN)
	$(PYTHON) basdev.py $(MAIN) $(SOURCE) 10 

clean:
	rm -rf ./dist
	mkdir ./dist

run:
	cpct_rvm ./dist/dungeon.dsk

SHELL=/bin/bash
# TARGET_FILE_PATH=ls
# TARGET_FILE_PATH=cat
# TARGET_FILE_PATH=ps
TARGET_FILE_PATH=sample/hello3

.PHONY: r2/gendot
r2/gendot:
	r2 -d -c "aaaa" -c "agCd>out/${TARGET_FILE_PATH}.dot" -q ${TARGET_FILE_PATH}

.PHONY: r2/gengml
r2/gengml:
	r2 -d -c "aaaa" -c "agCg>out/${TARGET_FILE_PATH}.gml" -q ${TARGET_FILE_PATH}

.PHONY: r2/genjson
r2/genjson:
	r2 -d -c "aaaa" -c "agCj>out/${TARGET_FILE_PATH}.json" -q ${TARGET_FILE_PATH}

.PHONY: genimage
genimage:
	dot -Tpng -o out/${TARGET_FILE_PATH}.png out/${TARGET_FILE_PATH}.dot

.PHONY: init
init:
	: sudo apt update
	sudo apt install -y python3-venv graphviz graphviz-dev python3-pytest
	: python3 -m venv venv
	source venv/bin/activate
	: python3 -m pip install --upgrade pip
	python3 -m pip install -r requirements.txt

.PHONY: test
test:
	source venv/bin/activate
	python3 -m pytest -q -p no:warnings .

.PHONY: docker/run
docker/run:
	docker run --rm -it r2-dot-sim:latest /bin/bash

.PHONY: docker/build
docker/build:
	docker build -t r2-dot-sim:latest . 

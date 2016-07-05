YUI_URL = http://yui.zenfs.com/releases/yui3/yui_3.18.1.zip
BUNDLES = yui.bundle.min.js yui.bundle.min.css
OUTDIR  = assets/vendor

BUNDLE_FILES = $(patsubst %, $(OUTDIR)/%, $(BUNDLES))

.PHONY: all build clean

all: build

build: $(BUNDLE_FILES)

clean:
	rm -f $(BUNDLE_FILES)
	rm -f yui.zip
	rm -rf yui

yui.zip:
	wget -O $@ $(YUI_URL)

yui: yui.zip
	mkdir -p yui
	unzip yui.zip 'yui/build/*'

$(OUTDIR)/%: yui
	@cat $*.manifest | while read file ; do cat yui/build/$$file >> $@ ; done


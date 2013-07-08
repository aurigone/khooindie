
CPDIR=cp -r
CP=cp
RMDIR=rm -r

GIT = hump tileloader
FOLDERS = 3rdparty data graphics levels src
FILES = main.lua README.md run.sh
BUILD = build/
COMPRESSER = 7z a
ARCHIVE := build_$(shell date +'%y.%m.%d').7z

.PHONY : all clean compress $(GIT) $(FOLDERS) $(FILES)

all: $(GIT) $(FOLDERS) $(FILES)

archive: clean all compress

compress:
	$(RMDIR) -f $(BUILD)/graphics/save
	$(COMPRESSER) $(ARCHIVE) $(BUILD)

$(GIT):
	$(CPDIR) $@ $(BUILD)
	$(RM) $(BUILD)$@/.git

$(FOLDERS):
	$(CPDIR) $@ $(BUILD)

$(FILES):
	$(CP) $@ $(BUILD)

clean:
	$(RMDIR) $(BUILD)*



BUILD = build
BOOKNAME = TheCrimsonKing
TITLE = title.txt
METADATA = metadata.yaml
CHAPTERS = src/HowCouldIFallIntoYourHandsRosyMaid.markdown src/LadyFair.markdown src/TheGrandBall.markdown src/OdetoaPrincess.markdown src/AWanderingStar.markdown src/LittleLight.markdown src/ASirensSong.markdown src/AllAlongTheInterlude.markdown src/IWhishICouldJustDieIWishIWasAlive.markdown src/TheCastle.markdown src/ThroneOfMight.markdown src/ICouldNotFindTheFaultsOfMyShaplessForm.markdown
TOC = --toc --toc-depth=2
COVER_IMAGE = resources/TheCrimsonKingCover.jpg
COVER = resources/cover.xhtml
LATEX_CLASS = book
EPUB_CSS = css/blitz-lite-poetry.min.css

all: book

book: epub html pdf

clean:
	rm -r $(BUILD)

epub: $(BUILD)/$(BOOKNAME).epub

html: $(BUILD)/$(BOOKNAME).html

pdf: $(BUILD)/$(BOOKNAME).pdf

$(BUILD)/$(BOOKNAME).epub: $(CHAPTERS)
	mkdir -p $(BUILD)
	pandoc $(TOC) -S --epub-stylesheet=$(EPUB_CSS) --epub-cover-image=$(COVER_IMAGE) $(METADATA) -o $@ $^
	# The next to file adds xhtml so that the cover properly rescales on all devices
	cp $(COVER) cover.xhtml
	zip -m $@ cover.xhtml

$(BUILD)/$(BOOKNAME).html: $(CHAPTERS)
	mkdir -p $(BUILD)
	pandoc $(TOC) --standalone --to=html5 -o $@ $^

$(BUILD)/$(BOOKNAME).pdf: $(TITLE) $(CHAPTERS)
	mkdir -p $(BUILD)
	pandoc $(TOC) --latex-engine=xelatex -V documentclass=$(LATEX_CLASS) -o $@ $^

.PHONY: all book clean epub html pdf

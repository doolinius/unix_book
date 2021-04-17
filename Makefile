BOOK_NAME=unix_book
COVER=graphics/cover.jpg
HTML_CHAPTERS=ch0.html ch1.html ch2.html ch3.html ch4.html ch5.html ch6.html ch7.html ch8.html ch9.html ch10.html ch11.html ch12.html ch13.html ch14.html ch15.html appendix.html 
FRONT=front.html
KINDLEGEN_PATH=/usr/local/bin/kindlegen
KINDLEGEN_FLAGS=
CALIBRE=calibre
CALIBRE_FLAGS=--output-profile=nook --input-profile=kindle
LATEX=latex
EPUB=$(BOOK_NAME).epub
OPF=$(BOOK_NAME).opf
NCX=$(BOOK_NAME).ncx
MOBI=$(BOOK_NAME).mobi
TEX=$(BOOK_NAME).tex
TEX_CHAPTERS=introduction.tex installing.tex command_line.tex users_and_groups.tex desktop.tex unix_permissions.tex hard_disks.tex processes.tex installing_software.tex networking.tex lamp.tex system_administration.tex shell_scripting.tex anti_virus.tex appendix.tex
PDF=$(BOOK_NAME).pdf

.SUFFIXES: .html .tex

%.html: %.tex
	./tex2html.pl $(*).tex

$(BOOK_NAME).pdf: $(TEX_CHAPTERS) $(TEX)
	pdflatex $(TEX)
	pdflatex $(TEX)

#$(BOOK_NAME).mobi: $(COVER) $(HTML_CHAPTERS) $(FRONT) $(OPF) $(NCX)
$(BOOK_NAME).mobi: $(HTML_CHAPTERS) $(OPF) $(NCX)
	$(KINDLEGEN_PATH) $(KINDLEGEN_FLAGS) $(OPF)

mobi: $(MOBI)

$(BOOK_NAME).epub: $(MOBI)
	ebook-convert $(MOBI) $(EPUB) $(CALIBRE_FLAGS)

epub: $(EPUB)

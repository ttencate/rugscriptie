.PHONY: all clean
all: rugscriptie.zip rugscriptie-example.pdf

clean:
	rm -f georgia.*pk georgia.afm georgia.tfm ttfonts.map *.aux *.log *.toc rugscriptie-manual.pdf rugscriptie-example.pdf rugscriptie.zip
	rm -f *~ *.backup

rugscriptie.zip: georgia.ttf georgia.afm georgia.tfm t1georgia.fd rugscriptie-manual.tex rugscriptie-manual.pdf rugscriptie.sty ttfonts.map ruglogos
	zip -r rugscriptie.zip $^

rugscriptie-manual.pdf: rugscriptie-manual.tex rugscriptie.sty
	pdflatex $<
	pdflatex $<

rugscriptie-example.pdf: rugscriptie-example.tex rugscriptie.sty
	pdflatex $<

rugscriptie.sty: georgia.ttf georgia.afm georgia.tfm ttfonts.map t1georgia.fd

# Based on instructions from
# http://fachschaft.physik.uni-greifswald.de/~stitch/ttf.html
# Input file: georgia.ttf (from MS core fonts)
# Input file: T1-WGL4.enc (from texmf/font/enc/ttf2pk/base, no need to copy it if TeX can find it)
# Input file: t1georgia.fd (hand-written, needed by LaTeX but not by this Makefile)

georgia.afm: georgia.ttf
	ttf2afm -e T1-WGL4.enc -o $@ $<

georgia.tfm: georgia.afm
	afm2tfm $< -T T1-WGL4.enc $@

ttfonts.map:
	echo "georgia georgia.ttf Encoding=T1-WGL4.enc" > $@

# Unmaintained, broken stuff for non-PDF fonts.
#ttfonts.map ecgeorgia.vpl recgeorgia.tfm:
#	ttf2tfm Georgia.ttf -q -T T1-WGL4.enc -v ecgeorgia.vpl recgeorgia.tfm > ttfonts.map
#ecgeorgia.vf:
#	vptovf ecgeorgia.vpl ecgeorgia.vf ecgeorgia.tfm
#recgeorgia.600pk:
#	ttf2pk -q ecgeorgia 600

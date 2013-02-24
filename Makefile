# Licensed under the Tumbolia Public License. See footer for details.

.PHONY: orig-art cards icons vendor

all: help

#-------------------------------------------------------------------------------
watch: 
	@node_modules/.bin/wr "make build" \
		src \
		web/index.html \
		web/main.css

#-------------------------------------------------------------------------------
build: 
	@echo "running build"

	@mkdir -p tmp
	@-rm      tmp/*

	@node_modules/.bin/coffee --bare --compile --output tmp src/*

	@node_modules/.bin/browserify \
		--outfile web/modules.js \
		--insert-globals \
		tmp/main.js

#-------------------------------------------------------------------------------
vendor: \
	vendor-init \
	vendor-bootstrap \
	vendor-jquery

#-------------------------------------------------------------------------------
vendor-bootstrap:

	@mkdir -p web/vendor/bootstrap
	@curl -o  web/vendor/bootstrap/bootstrap.zip $(BOOTSTRAP_URL)
	@unzip    web/vendor/bootstrap/bootstrap.zip -d web/vendor/bootstrap
	@mv       web/vendor/bootstrap/bootstrap/*      web/vendor/bootstrap
	@rm       web/vendor/bootstrap/bootstrap.zip
	@rmdir    web/vendor/bootstrap/bootstrap

BOOTSTRAP_URL = http://twitter.github.com/bootstrap/assets/bootstrap.zip

#-------------------------------------------------------------------------------
vendor-jquery:
	curl -o web/vendor/jquery.min.js  $(JQUERY_URL).min.js
	curl -o web/vendor/jquery.js      $(JQUERY_URL).js

JQUERY_URL = http://code.jquery.com/jquery-1.9.0

#-------------------------------------------------------------------------------
vendor-init:
	@-rm -rf  web/vendor
	@mkdir -p web/vendor


#-------------------------------------------------------------------------------
cards-PDF-2-PNG:
	@echo converting cards from PDFs to PNGs

	@-mkdir -p tmp
	@-rm       tmp/*

	@convert -density 300 orig-art/board.pdf     tmp/board.png
	@convert -density 300 orig-art/backs.pdf     tmp/backs.png
	@convert -density 300 orig-art/cards.pdf[0]  tmp/cards-0.png
	@convert -density 300 orig-art/cards.pdf[1]  tmp/cards-1.png
	@convert -density 300 orig-art/cards.pdf[2]  tmp/cards-2.png
	@convert -density 300 orig-art/cards.pdf[3]  tmp/cards-3.png
	@convert -density 300 orig-art/cards.pdf[4]  tmp/cards-4.png
	@convert -density 300 orig-art/cards.pdf[5]  tmp/cards-5.png
	@convert -density 300 orig-art/cards.pdf[6]  tmp/cards-6.png
	@convert -density 300 orig-art/cards.pdf[7]  tmp/cards-7.png
	@convert -density 300 orig-art/cards.pdf[8]  tmp/cards-8.png
	@convert -density 300 orig-art/cards.pdf[9]  tmp/cards-9.png
	@convert -density 300 orig-art/money.pdf[0]  tmp/money-0.png
	@convert -density 300 orig-art/money.pdf[1]  tmp/money-1.png
	@convert -density 300 orig-art/money.pdf[2]  tmp/money-2.png
	@convert -density 300 orig-art/money.pdf[3]  tmp/money-3.png
	@convert -density 300 orig-art/money.pdf[4]  tmp/money-4.png
	@convert -density 300 orig-art/money.pdf[5]  tmp/money-5.png
	@convert -density 300 orig-art/money.pdf[6]  tmp/money-6.png
	@convert -density 300 orig-art/money.pdf[7]  tmp/money-7.png
	@convert -density 300 orig-art/money.pdf[8]  tmp/money-8.png

#-------------------------------------------------------------------------------
cards: cards-PDF-2-PNG
	@echo extracting cards

	@mkdir -p web/images/cards 
	@-rm      web/images/cards/*

	@convert -resize 1200x1000 tmp/board.png  web/images/board.png

	@convert -extract 747x1046+0150+0076 -resize 200x280 tmp/backs.png   web/images/cards/card-b01.png

	@echo extracting cards from page 1
	@convert -extract 747x1046+0150+0076 -resize 200x280 tmp/cards-0.png web/images/cards/card-s01.png
	@convert -extract 747x1046+0901+0076 -resize 200x280 tmp/cards-0.png web/images/cards/card-s02.png
	@convert -extract 747x1046+1651+0076 -resize 200x280 tmp/cards-0.png web/images/cards/card-s03.png
	@convert -extract 747x1046+0150+1127 -resize 200x280 tmp/cards-0.png web/images/cards/card-s04.png
	@convert -extract 747x1046+0901+1127 -resize 200x280 tmp/cards-0.png web/images/cards/card-s05.png
	@convert -extract 747x1046+1651+1127 -resize 200x280 tmp/cards-0.png web/images/cards/card-s06.png
	@convert -extract 747x1046+0150+2178 -resize 200x280 tmp/cards-0.png web/images/cards/card-s07.png
	@convert -extract 747x1046+0901+2178 -resize 200x280 tmp/cards-0.png web/images/cards/card-s08.png
	@convert -extract 747x1046+1651+2178 -resize 200x280 tmp/cards-0.png web/images/cards/card-s09.png

	@echo extracting cards from page s
	@convert -extract 747x1046+0150+0076 -resize 200x280 tmp/cards-1.png web/images/cards/card-s10.png
	@convert -extract 747x1046+0901+0076 -resize 200x280 tmp/cards-1.png web/images/cards/card-s11.png
	@convert -extract 747x1046+1651+0076 -resize 200x280 tmp/cards-1.png web/images/cards/card-s12.png
	@convert -extract 747x1046+0150+1127 -resize 200x280 tmp/cards-1.png web/images/cards/card-s13.png
	@convert -extract 747x1046+0901+1127 -resize 200x280 tmp/cards-1.png web/images/cards/card-s14.png
	@convert -extract 747x1046+1651+1127 -resize 200x280 tmp/cards-1.png web/images/cards/card-s15.png
	@convert -extract 747x1046+0150+2178 -resize 200x280 tmp/cards-1.png web/images/cards/card-s16.png
	@convert -extract 747x1046+0901+2178 -resize 200x280 tmp/cards-1.png web/images/cards/card-s17.png
	@convert -extract 747x1046+1651+2178 -resize 200x280 tmp/cards-1.png web/images/cards/card-s18.png

	@echo extracting cards from page 3
	@convert -extract 747x1046+0150+0076 -resize 200x280 tmp/cards-2.png web/images/cards/card-s19.png
	@convert -extract 747x1046+0901+0076 -resize 200x280 tmp/cards-2.png web/images/cards/card-s20.png
	@convert -extract 747x1046+1651+0076 -resize 200x280 tmp/cards-2.png web/images/cards/card-s21.png
	@convert -extract 747x1046+0150+1127 -resize 200x280 tmp/cards-2.png web/images/cards/card-s22.png
	@convert -extract 747x1046+0901+1127 -resize 200x280 tmp/cards-2.png web/images/cards/card-s23.png
	@convert -extract 747x1046+1651+1127 -resize 200x280 tmp/cards-2.png web/images/cards/card-c01.png
	@convert -extract 747x1046+0150+2178 -resize 200x280 tmp/cards-2.png web/images/cards/card-c02.png
	@convert -extract 747x1046+0901+2178 -resize 200x280 tmp/cards-2.png web/images/cards/card-c03.png
	@convert -extract 747x1046+1651+2178 -resize 200x280 tmp/cards-2.png web/images/cards/card-c04.png

	@echo extracting cards from page 4
	@convert -extract 747x1046+0150+0076 -resize 200x280 tmp/cards-3.png web/images/cards/card-c05.png
	@convert -extract 747x1046+0901+0076 -resize 200x280 tmp/cards-3.png web/images/cards/card-c06.png
	@convert -extract 747x1046+1651+0076 -resize 200x280 tmp/cards-3.png web/images/cards/card-c07.png
	@convert -extract 747x1046+0150+1127 -resize 200x280 tmp/cards-3.png web/images/cards/card-c08.png
	@convert -extract 747x1046+0901+1127 -resize 200x280 tmp/cards-3.png web/images/cards/card-c09.png
	@convert -extract 747x1046+1651+1127 -resize 200x280 tmp/cards-3.png web/images/cards/card-c10.png
	@convert -extract 747x1046+0150+2178 -resize 200x280 tmp/cards-3.png web/images/cards/card-c11.png
	@convert -extract 747x1046+0901+2178 -resize 200x280 tmp/cards-3.png web/images/cards/card-c12.png
	@convert -extract 747x1046+1651+2178 -resize 200x280 tmp/cards-3.png web/images/cards/card-c13.png

	@echo extracting cards from page 5
	@convert -extract 747x1046+0150+0076 -resize 200x280 tmp/cards-4.png web/images/cards/card-c14.png
	@convert -extract 747x1046+0901+0076 -resize 200x280 tmp/cards-4.png web/images/cards/card-c15.png
	@convert -extract 747x1046+1651+0076 -resize 200x280 tmp/cards-4.png web/images/cards/card-c16.png
	@convert -extract 747x1046+0150+1127 -resize 200x280 tmp/cards-4.png web/images/cards/card-c17.png
	@convert -extract 747x1046+0901+1127 -resize 200x280 tmp/cards-4.png web/images/cards/card-c18.png
	@convert -extract 747x1046+1651+1127 -resize 200x280 tmp/cards-4.png web/images/cards/card-c19.png
	@convert -extract 747x1046+0150+2178 -resize 200x280 tmp/cards-4.png web/images/cards/card-c20.png
	@convert -extract 747x1046+0901+2178 -resize 200x280 tmp/cards-4.png web/images/cards/card-c21.png
	@convert -extract 747x1046+1651+2178 -resize 200x280 tmp/cards-4.png web/images/cards/card-c22.png

	@echo extracting cards from page 6
	@convert -extract 747x1046+0150+0076 -resize 200x280 tmp/cards-5.png web/images/cards/card-c23.png
	@convert -extract 747x1046+0901+0076 -resize 200x280 tmp/cards-5.png web/images/cards/card-e01.png
	@convert -extract 747x1046+1651+0076 -resize 200x280 tmp/cards-5.png web/images/cards/card-e02.png
	@convert -extract 747x1046+0150+1127 -resize 200x280 tmp/cards-5.png web/images/cards/card-e03.png
	@convert -extract 747x1046+0901+1127 -resize 200x280 tmp/cards-5.png web/images/cards/card-e04.png
	@convert -extract 747x1046+1651+1127 -resize 200x280 tmp/cards-5.png web/images/cards/card-e05.png
	@convert -extract 747x1046+0150+2178 -resize 200x280 tmp/cards-5.png web/images/cards/card-e06.png
	@convert -extract 747x1046+0901+2178 -resize 200x280 tmp/cards-5.png web/images/cards/card-e07.png
	@convert -extract 747x1046+1651+2178 -resize 200x280 tmp/cards-5.png web/images/cards/card-e08.png

	@echo extracting cards from page 7
	@convert -extract 747x1046+0150+0076 -resize 200x280 tmp/cards-6.png web/images/cards/card-e09.png
	@convert -extract 747x1046+0901+0076 -resize 200x280 tmp/cards-6.png web/images/cards/card-e10.png
	@convert -extract 747x1046+1651+0076 -resize 200x280 tmp/cards-6.png web/images/cards/card-e11.png
	@convert -extract 747x1046+0150+1127 -resize 200x280 tmp/cards-6.png web/images/cards/card-e12.png
	@convert -extract 747x1046+0901+1127 -resize 200x280 tmp/cards-6.png web/images/cards/card-e13.png
	@convert -extract 747x1046+1651+1127 -resize 200x280 tmp/cards-6.png web/images/cards/card-e14.png
	@convert -extract 747x1046+0150+2178 -resize 200x280 tmp/cards-6.png web/images/cards/card-e15.png
	@convert -extract 747x1046+0901+2178 -resize 200x280 tmp/cards-6.png web/images/cards/card-e16.png
	@convert -extract 747x1046+1651+2178 -resize 200x280 tmp/cards-6.png web/images/cards/card-e17.png

	@echo extracting cards from page 8
	@convert -extract 747x1046+0150+0076 -resize 200x280 tmp/cards-7.png web/images/cards/card-e18.png
	@convert -extract 747x1046+0901+0076 -resize 200x280 tmp/cards-7.png web/images/cards/card-e19.png
	@convert -extract 747x1046+1651+0076 -resize 200x280 tmp/cards-7.png web/images/cards/card-e20.png
	@convert -extract 747x1046+0150+1127 -resize 200x280 tmp/cards-7.png web/images/cards/card-e21.png
	@convert -extract 747x1046+0901+1127 -resize 200x280 tmp/cards-7.png web/images/cards/card-o01.png
	@convert -extract 747x1046+1651+1127 -resize 200x280 tmp/cards-7.png web/images/cards/card-o02.png
	@convert -extract 747x1046+0150+2178 -resize 200x280 tmp/cards-7.png web/images/cards/card-o03.png
	@convert -extract 747x1046+0901+2178 -resize 200x280 tmp/cards-7.png web/images/cards/card-m01.png
	@convert -extract 747x1046+1651+2178 -resize 200x280 tmp/cards-7.png web/images/cards/card-m02.png

	@echo extracting cards from page 9
	@convert -extract 747x1046+0150+0076 -resize 200x280 tmp/cards-8.png web/images/cards/card-m03.png
	@convert -extract 747x1046+0901+0076 -resize 200x280 tmp/cards-8.png web/images/cards/card-m04.png
	@convert -extract 747x1046+1651+0076 -resize 200x280 tmp/cards-8.png web/images/cards/card-m05.png
	@convert -extract 747x1046+0150+1127 -resize 200x280 tmp/cards-8.png web/images/cards/card-m06.png
	@convert -extract 747x1046+0901+1127 -resize 200x280 tmp/cards-8.png web/images/cards/card-m07.png
	@convert -extract 747x1046+1651+1127 -resize 200x280 tmp/cards-8.png web/images/cards/card-m08.png
	@convert -extract 747x1046+0150+2178 -resize 200x280 tmp/cards-8.png web/images/cards/card-m09.png
	@convert -extract 747x1046+0901+2178 -resize 200x280 tmp/cards-8.png web/images/cards/card-m10.png
	@convert -extract 747x1046+1651+2178 -resize 200x280 tmp/cards-8.png web/images/cards/card-m11.png

	@echo extracting cards from page 10
	@convert -extract 747x1046+0150+0076 -resize 200x280 tmp/cards-9.png web/images/cards/card-m12.png
	@convert -extract 747x1046+0901+0076 -resize 200x280 tmp/cards-9.png web/images/cards/card-m13.png
	@convert -extract 747x1046+1651+0076 -resize 200x280 tmp/cards-9.png web/images/cards/card-m14.png
	@convert -extract 747x1046+0150+1127 -resize 200x280 tmp/cards-9.png web/images/cards/card-m15.png
	@convert -extract 747x1046+0901+1127 -resize 200x280 tmp/cards-9.png web/images/cards/card-m16.png
	@convert -extract 747x1046+1651+1127 -resize 200x280 tmp/cards-9.png web/images/cards/card-m17.png
	@convert -extract 747x1046+0150+2178 -resize 200x280 tmp/cards-9.png web/images/cards/card-m18.png
	@convert -extract 747x1046+0901+2178 -resize 200x280 tmp/cards-9.png web/images/cards/card-m19.png
	@convert -extract 747x1046+1651+2178 -resize 200x280 tmp/cards-9.png web/images/cards/card-m20.png

	@echo extracting money

	@mkdir -p web/images/money
	@-rm      web/images/money/*

	@convert -background "#CFFDDB" -flatten tmp/money-0.png tmp/money-g0.png 
	@convert -background "#CFFDDB" -flatten tmp/money-1.png tmp/money-g1.png 
	@convert -background "#CFFDDB" -flatten tmp/money-2.png tmp/money-g2.png 
	@convert -background "#CFFDDB" -flatten tmp/money-3.png tmp/money-g3.png 
	@convert -background "#CFFDDB" -flatten tmp/money-4.png tmp/money-g4.png 
	@convert -background "#CFFDDB" -flatten tmp/money-5.png tmp/money-g5.png 
	@convert -background "#CFFDDB" -flatten tmp/money-6.png tmp/money-g6.png 
	@convert -background "#CFFDDB" -flatten tmp/money-7.png tmp/money-g7.png 
	@convert -background "#CFFDDB" -flatten tmp/money-8.png tmp/money-g8.png 

	@convert -extract 1222x622+63+141 tmp/money-g0.png web/images/money/1.png
	@convert -extract 1222x622+63+141 tmp/money-g1.png web/images/money/5.png
	@convert -extract 1222x622+63+141 tmp/money-g2.png web/images/money/10.png
	@convert -extract 1222x622+63+141 tmp/money-g3.png web/images/money/20.png
	@convert -extract 1222x622+63+141 tmp/money-g4.png web/images/money/50.png
	@convert -extract 1222x622+63+141 tmp/money-g5.png web/images/money/100.png
	@convert -extract 1222x622+63+141 tmp/money-g6.png web/images/money/200.png
	@convert -extract 1222x622+63+141 tmp/money-g7.png web/images/money/500.png
	@convert -extract 1222x622+63+141 tmp/money-g8.png web/images/money/1000.png

#-----------------------------------------------------
# card 
#    page height:     3300
#    left-corner:      150, 76
#    margin:            37
#    card-left:        188
#    card-right:       861
#    card-width:       673
#    card-width-m:     747
#    card-top:         114
#    card-bottom:     1086
#    card-height:      972
#    card-height-m:   1046
#    card-next-left:   938
#    card-next-top-1: 2136
#
#-----------------------------------------------------

#-----------------------------------------------------
# money
#    page height:     3300
#    top:              178 (3122)
#    left:             100
#    margin:            37
#    height            548 (2574)
#    width:           1149

#-------------------------------------------------------------------------------
icons:
	@echo converting icons

	@-mkdir -p web/images/icons
	@-rm       web/images/icons/*

	@convert -resize 057x057 orig-art/icon.jpg web/images/icons/icon-057.png
	@convert -resize 072x072 orig-art/icon.jpg web/images/icons/icon-072.png
	@convert -resize 114x114 orig-art/icon.jpg web/images/icons/icon-114.png
	@convert -resize 144x144 orig-art/icon.jpg web/images/icons/icon-144.png

	@convert -resize 032x032 orig-art/icon.jpg web/images/icons/icon-032.png
	@convert -resize 064x064 orig-art/icon.jpg web/images/icons/icon-064.png
	@convert -resize 128x128 orig-art/icon.jpg web/images/icons/icon-128.png


#-------------------------------------------------------------------------------
orig-art:
	@-mkdir -p orig-art
	@-rm       orig-art/*

	@echo downloading original artwork

	@wget -O orig-art/rules.pdf http://www.cheapass.com/sites/default/files/WitchTrialRules.pdf
	@wget -O orig-art/board.pdf http://www.cheapass.com/sites/default/files/WTFullBleedBoard.pdf
	@wget -O orig-art/cards.pdf http://www.cheapass.com/sites/default/files/WitchTrialCards.pdf
	@wget -O orig-art/backs.pdf http://www.cheapass.com/sites/default/files/WitchTrialCardBacks.pdf
	@wget -O orig-art/icon.jpg  http://www.cheapass.com/sites/default/files/WTBug2.jpg
	@wget -O orig-art/money.pdf http://www.cheapass.com/sites/default/files/CheapassMoneyPDF.pdf

#-------------------------------------------------------------------------------
help:
	@echo "targets:"
	@echo "   build    - run a build"
	@echo "   watch    - watch for source changes, then run a build"
	@echo "   vendor   - download 3rd party files"
	@echo "   orig-art - download the original artwork"
	@echo "   cards    - generate card images from the original media"
	@echo "   icons    - generate icons from the original media" 

	@echo "You'll need to run orig before cards and before icons."

#-------------------------------------------------------------------------------
# Copyright (c) 2013 Patrick Mueller
#
# Tumbolia Public License
#
# Copying and distribution of this file, with or without modification, are
# permitted in any medium without royalty provided the copyright notice and
# this notice are preserved.
#
# TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#   0. opan saurce LOL
#-------------------------------------------------------------------------------
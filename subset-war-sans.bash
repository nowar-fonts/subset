# /bin/bash

mkdir -p subset/

for file in $(ls *.ttf)
do
	pyftsubset "$file" \
		--unicodes-file=charset/adobe-latin-3.uni --unicodes-file=charset/adobe-cyrillic-1.uni --unicodes-file=charset/adobe-greek-1.uni \
		--unicodes-file=charset/uro.uni --unicodes-file=charset/hangul.uni \
		--unicodes-file=charset/adobe-gb1-2.uni --unicodes-file=charset/adobe-cns1-0.uni --unicodes-file=charset/adobe-japan1-2.uni --unicodes-file=charset/adobe-korea1-1.uni \
		--unicodes-file=charset/cn-general-8105.uni --text-file=charset/jp-freq-2136.txt --text-file=charset/jp-name-863.txt \
		--output-file=subset/"$file" \
		--notdef-glyph --notdef-outline \
		--no-recommended-glyphs \
		--layout-features=ccmp,kern,liga,lnum,mark,mkmk,onum,pnum,tnum \
		--layout-scripts='*' \
		--no-hinting \
		--desubroutinize \
		--no-legacy-kern \
		--no-name-legacy \
		--name-languages=0x0409 \
		--obfuscate-names \
		--no-glyph-names \
		--no-legacy-cmap \
		--no-symbol-cmap \
		--recalc-bounds \
		--no-recalc-timestamp \
		--no-canonical-order \
		--prune-unicode-ranges \
		--recalc-average-width \
		--recalc-max-context \
		--timing \
	&& otfccdump subset/"$file" | otfccbuild -O2 --ignore-glyph-order --keep-average-char-width --keep-unicode-ranges --keep-modified-time --subroutinize -o subset/"$file" &
done
wait

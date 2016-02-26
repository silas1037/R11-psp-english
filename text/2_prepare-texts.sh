#!/bin/sh

# The text in www* folders was copied to chapters-psp/ and edited because of mismatches between pc and psp versions.
# extract_en.pl extracts the english lines from the raw translation file, changes encoding, converts unsupported characters etc.
# This allows a less painful further processing and insertion into scenes.

# Shift-JIS reference tables
# https://msdn.microsoft.com/en-us/goglobal/cc305152.aspx

# Dependencies: Perl File::Slurp module.
# > cpan File::Slurp

mkdir -p mac-en-only/
for i in chapters-psp/[A-Z0-9]*_[0-9]*.txt ; do
	f=`basename $i .txt`
	echo Processing translation: $i
	# process special characters and remove unimportant lines
    ./extract_en.pl chapters-psp/$f.txt > mac-en-only/$f.txt || exit 1;
	
	# combine with my format
	./insert_en_lines.py mac-ja-psp/$f.txt mac-en-only/$f.txt mac-combined-psp/$f.txt || exit 1;
done
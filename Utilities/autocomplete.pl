#!/usr/bin/env perl
#
# $Id: autocomplete.pl 482 2008-01-12 23:07:32Z fletcher $
#
# Find possible autocompletions in a MultiMarkdown file
# ( Designed to be called from TextMate, but the concept can be used elsewhere. )
#
#
# Copyright (c) 2006-2008 Fletcher T. Penney
#	<http://fletcherpenney.net/>
#
# MultiMarkdown Version 2.0.b5
#

# local $/;
$word_to_match = $ENV{'TM_CURRENT_WORD'};

# Read in source file
$multimarkdown_file = $ENV{'TM_FILEPATH'};


open(MULTI, "<$multimarkdown_file");
local $/;
$multi_source = <MULTI>;

if ( $word_to_match =~ s/^\^/\\^/) {

	# Match Footnotes
	# the '^' makes things tricky

	$multi_source =~ s/^(?:\[($word_to_match.+?)\]:)?.*$/$1/img;
	$word_to_match =~ s/\\\^/^/g;

} elsif ($word_to_match =~ /^\#/) {	

	# Match MultiMarkdown Citations

	$multi_source =~ s/^(?:\[($word_to_match.+?)\]:)?.*$/$1/img;

	#BibTex Citations
	
	# Slurp any .bib files
	open (BIB, "cd $ENV{'TM_DIRECTORY'}; cat *.bib |");
	local $/;
	$bibtex = <BIB>;
	$word_only = $word_to_match;
	$word_only =~ s/^#//;
	$bibtex =~ s{
		^(?:@.*?\{($word_only.+?)\,)?.*$
		}{
			$match = $1;
			$match =~ s/(...)/#$1/;
			$match;
		}xeimg;
	$multi_source .= $bibtex;

} else {

	# Match regular anchor (link or image)
	
	$multi_source =~ s{
		^(?:
			(?:\#{1,6}\s*|\[)
			($word_to_match.+?)					# Match Heading
			(?:\]:|\s*\#)
		)?
		(?:.*\[($word_to_match.+?)\]>>)?		# Match Equation label
		(?:\[.*?\]\[($word_to_match.+?)\])?		# Match Table label (or at least a label
		.*?$									# 	at the beginning of a line)
	}{
		"$1$2$3";
	}gemix;
}

# Strip blank lines
$multi_source =~ s/\n\s*\n/\n/gs;

# Fix case (TextMate won't autocomplete different cases)
if ($word_to_match =~ /^\^/) {
	$multi_source =~ s/\^+$word_to_match/$word_to_match/igm;
} else {
	$multi_source =~ s/^$word_to_match/$word_to_match/igm;
}

# Print

print $multi_source;

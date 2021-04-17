#!/usr/bin/perl

use File::Slurp;
$SOURCE=$ARGV[0];
$DEST= $SOURCE; $DEST =~ s/\.tex$/.html/;
if($SOURCE =~ /^ch(\d+)\.tex/) {
   $CHAPTER = $1;
}
print "Going from $SOURCE -> $DEST\n";
my $tex = read_file($SOURCE);
$tex .= "\n" unless $tex =~ /\n$/m;
$tex =~ s{\s*\\chapter.*$}{}m;
$tex =~ s{\\\\}{<br />}g;
$tex =~ s{\\,}{&amp;nbsp;}g;
$tex =~ s[\\begin{quote}][<blockquote>]g;
$tex =~ s[\\end{quote}][</blockquote>]g;
$tex =~ s[\\emph{(.*?)}][<em>$1</em>]sg;
$tex =~ s[\\ldots][. . .]g;
$tex =~ s{\\-}{}g;
$tex =~ s{%.*?\n}{}mg; # remove TeX comments
$tex =~ s{^\s*}{};
$tex =~ s{\n\n+}{\n</p><p>\n}g;
$tex =~ s{\\'e}{&amp;eacute;}g;
$tex =~ s[\\c{c}]{&amp;ccedil;}g;
$tex =~ s{``}{&amp;ldquo;}g;
$tex =~ s{''}{&amp;rdquo;}g;
$tex =~ s{`}{&amp;lsquo;}g;
$tex =~ s{'}{&amp;rsquo;}g;
$tex =~ s{---}{&amp;mdash;}g;
$tex =~ s{~}{&amp;nbsp;}g;
$tex =~ s{\\"i}{&amp;iuml;}g;
$tex =~ s{\\sectionbreak}{<div class="centered">\* \* \*</div>}g;
$tex =~ s[{}][]g;

open my $fout, ">", $DEST or die "Unable to open $DEST\n";
print $fout <<EOH;
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Chapter $CHAPTER</title>
<link rel="stylesheet" href="style.css" type="text/css" />
</head>
<body>
<div>
EOH

if($CHAPTER) {
   print $fout "<h2><b>Chapter $CHAPTER</b></h2>\n";
}

print $fout "\n<p>\n" . $tex . "</p>\n";

print $fout "</div></body></html>\n";

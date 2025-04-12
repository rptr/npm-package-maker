#!/usr/bin/perl
use strict;
use warnings;

while (<>) {
    make_package($_);
}

sub make_package {
    my $word = shift;
    
    replace_word('index.js', $word);
    replace_word('package.json', $word);

    chdir 'new-package';
    system('npm', 'publish', '--access public');
    chdir '..';
}

sub replace_word {
    my $file = shift;
    my $word = shift;

    chomp($word);

    open(my $in, '<', "template/$file") or die "template/$file: $!";
    open(my $out, '>', "new-package/$file") or die "index.js";

    while(<$in>) {
        $_ =~ s/WORD/$word/g;
        print $out $_;
    }

    close($in);
    close($out);
}

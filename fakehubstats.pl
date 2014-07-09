#!/usr/bin/env perl
use strict;
use warnings;
use 5.10.1;

use Getopt::Long;
use Pod::Usage;
use JSON;

my %opts;

GetOptions(\%opts,
	'help|h!',
) or pod2usage(1);
pod2usage(1) if $opts{help};


__END__

=head1 fakehubstats

Takes a list of git repos and generates a JSON feed similar to GitHub's 
contribution data

=head1 USAGE

	./fakehubstats.pl /path/to/git/repo

=head1 SYNOPSIS

	./fakehubstats.pl [options] /path/to/git/repo

	Options:
	  -h, --help            print help information

=head1 OPTIONS

=over 4

=item B<-h>, B<--help>

Prints the help for this program

=back

=head1 DESCRIPTION

fakehubstats takes a list of git repositories and generates a JSON feed that
imitates GitHub's contribution data.

=head1 DEPENDENCIES

fakehubstats uses JSON and assumes you have git installed.

=head1 EXAMPLES

	# print the simulated JSON feed for your personal git repo
	./fakehubstats.pl /path/to/git/repo

=head1 AUTHOR

Stan Schwertly (http://www.schwertly.com)
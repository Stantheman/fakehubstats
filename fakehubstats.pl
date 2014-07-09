#!/usr/bin/env perl
use strict;
use warnings;
use 5.10.1;

use Getopt::Long;
use Pod::Usage;
use JSON;

my $opts = get_options();

# 366 tuples of 2 entries each, date + score
# ["2014/05/11",10]
my @work;

for my $dir (@ARGV) {
	for my $line (qx(git --work-tree=$dir log --format="%at")) {
		my ($day, $month, $year) = (localtime($line))[3,4,5];
		$year += 1900;
		$month += 1;
		printf("%4d/%02d/%02d\n", $year, $month, $day);
	}
}

sub get_options {
	my %opts;

	GetOptions(\%opts,
		'help|h!',
	) or pod2usage(1);
	pod2usage(1) if $opts{help};

	return \%opts;
}

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
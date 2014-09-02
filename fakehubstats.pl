#!/usr/bin/env perl
use strict;
use warnings;
use 5.10.1;

use Getopt::Long;
use Pod::Usage;
use DateTime;
use JSON;

my $opts = get_options();

# 366 tuples of 2 entries each, date + score
# ["2014/05/11",10]

# 0 is today, 1 is yesterday...
my @days;
for my $dir (@ARGV) {
	for my $line (qx(git --git-dir=$dir/.git log --format="%at" --since="365 days ago")) {
		my $log_entry = DateTime->from_epoch(epoch => $line, time_zone=>'local');
		my $ago = DateTime->today(time_zone=>'local')->delta_days($log_entry)->in_units('days');
		$days[$ago]->[0] ||= $log_entry->set_time_zone('local')->ymd('-');
		$days[$ago]->[1]++;
	}
}

# fill in the empty days
for my $day (0..365) {
	$days[$day] ||= [DateTime->today(time_zone=>'local')->subtract(days=>$day)->set_time_zone('local')->ymd('-'), 0];
}

@days = reverse @days;

print encode_json(\@days);

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

fakehubstats is written in Perl and uses the JSON and DateTime modules.

=head1 EXAMPLES

	# print the simulated JSON feed for your personal git repo
	./fakehubstats.pl /path/to/git/repo

	# print the simulated JSON feed for your person git repos
	./fakehubstats.pl /path/to/git/repo/directory/*

=head1 AUTHOR

Stan Schwertly (http://www.schwertly.com)

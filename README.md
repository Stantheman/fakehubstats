# fakehubstats

Takes a list of git repos and generates a JSON feed similar to GitHub's 
contribution data

# USAGE

        ./fakehubstats.pl /path/to/git/repo

# SYNOPSIS

        ./fakehubstats.pl [options] /path/to/git/repo

        Options:
          -h, --help            print help information

# OPTIONS

- **-h**, **--help**

    Prints the help for this program

# DESCRIPTION

fakehubstats takes a list of git repositories and generates a JSON feed that
imitates GitHub's contribution data.

# DEPENDENCIES

fakehubstats uses JSON and assumes you have git installed.

# EXAMPLES

        # print the simulated JSON feed for your personal git repo
        ./fakehubstats.pl /path/to/git/repo

# AUTHOR

Stan Schwertly (http://www.schwertly.com)

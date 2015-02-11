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
imitates GitHub's contribution data. The primary reason fakehubstats exists is
to pump data into [akerl/githubchart](https://github.com/akerl/githubchart) to
create contribution data for private repositories.

If you have local clones of your public repositories, you can run this tool
across those repos and your private repos to create a combined contribution
graph. You may notice squares are colored on Github's graph where they're missing
on your own because you opened an issue on Github that day. A naive solution to this
problem is to combine both Github's data and your own by choosing the MAX for each day.
The following [jq](http://stedolan.github.io/jq/) one-liner should give you that:

    jq -r -s  'add | group_by(.[0]) |  map(max_by(.[1]))' fakehub.json gh.json

GitHub recently changed their private stats API. They now serve SVGs directly and
do not provide the JSON of the contributions. You can extract the information from
the SVG and transform it into JSON with an XML parser. You can also copy this dirty
one-liner, replacing in your username:
```
curl -s github.com/users/stantheman/contributions -L | grep data-date | perl -MJSON -nE 'if ($_ =~ /data-count="(\d+)" data-date="(.*)"/) { push @stuff, [$2, $1]} END{ print encode_json(\@stuff)}'
```
# DEPENDENCIES

fakehubstats is written in Perl and uses the JSON and DateTime modules.

On Debian-based systems:
```
apt-get install libjson-perl libdatetime-perl
```

# EXAMPLES

        # print the simulated JSON feed for your personal git repo
        ./fakehubstats.pl /path/to/git/repo

        # print the simulated JSON feed for your personal git repos
        ./fakehubstats.pl /path/to/git/repo/directory/*

# AUTHOR

Stan Schwertly (http://www.schwertly.com)

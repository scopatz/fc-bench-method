#!/usr/bin/env xonsh
"""Diffs the latex file and builds the pdf."""
import os
import sys
from argparse import ArgumentParser


def difftex(old):
    files = set(`.*?\.tex`) - set(`.*?-diff\.tex`)
    for f in files:
        print('diffing ' + f)
        fbase, fext = os.path.splitext(f)
        oldspec = old + ':' + f
        oldname = '/tmp/{0}-{1}{2}'.format(fbase, old, fext)
        diffname = '{0}-diff{1}'.format(fbase, fext)
        git show @(oldspec) > @(oldname)
        latexdiff --subtype=COLOR @(oldname) @(f) > @(diffname)


def main(args=None):
    parser = ArgumentParser('diff')
    parser.add_argument('old', help='Tree to compare against.')
    parser.add_argument('--manuscript', help='Diffed manuscript name', 
                        default='paper-diff', dest='manuscript')
    ns = parser.parse_args(args=args or $ARGS[1:])

    difftex(ns.old)
    make @('manuscript=' + ns.manuscript)
    

if __name__ == '__main__':
    main()

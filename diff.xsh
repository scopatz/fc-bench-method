#!/usr/bin/env xonsh
"""Diffs the latex file and builds the pdf."""
import sys
from argparse import ArgumentParser

def main(args=None):
    parser = ArgumentParser('diff')
    parser.add_argument('old', help='Tree to compare against.')
    ns = parser.parse_args(args=args or $ARGS[1:])


if __name__ == '__main__':
    main()

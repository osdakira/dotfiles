#!/usr/bin/env python

import os
import re
import sys
import compiler
from subprocess import Popen, PIPE

import logging
logging.basicConfig(filename='/tmp/lint.log', level=logging.DEBUG)
import traceback

PYLINT_COMMAND = "pylint"
PYCHECKER_COMMAND = "pychecker"
PEP8_COMMAND = "pep8"
PYFLAKES_COMMAND = "pyflakes"


class LintRunner(object):
    """ Base class provides common functionality to run
          python code checkers. """
    sane_default_ignore_codes = set([])
    command = None
    output_matcher = None
    #flymake: ("\\(.*\\) at \\([^ \n]+\\) line \\([0-9]+\\)[,.\n]" 2 3 nil 1)
    #or in non-retardate: r'(.*) at ([^ \n]) line ([0-9])[,.\n]'
    output_format = "%(level)s %(error_type)s%(error_number)s:" \
                    "%(description)s at %(filename)s line %(line_number)s."

    def __init__(self, virtualenv=None, ignore_codes=(),
                 use_sane_defaults=True):
        if virtualenv:
            # This is the least we can get away with (hopefully).
            self.env = {'VIRTUAL_ENV': virtualenv,
                        'PATH': virtualenv + '/bin:' + os.environ['PATH']}
        else:
            self.env = None
        self.virtualenv = virtualenv
        self.ignore_codes = set(ignore_codes)
        self.use_sane_defaults = use_sane_defaults

    @property
    def operative_ignore_codes(self):
        if self.use_sane_defaults:
            return self.ignore_codes | self.sane_default_ignore_codes
        else:
            return self.ignore_codes

    @property
    def run_flags(self):
        return ()

    @staticmethod
    def fixup_data(_line, data):
        return data

    @classmethod
    def process_output(cls, line):
        print line
        m = cls.output_matcher.match(line)
        if m:
            fixed_data = dict.fromkeys(('level', 'error_type',
                                        'error_number', 'description',
                                        'filename', 'line_number'),
                                       '')
            fixed_data.update(cls.fixup_data(line, m.groupdict()))
            fixed_data['description'] = (
                cls.__name__ + ' ' + fixed_data['description'])
            print cls.output_format % fixed_data
        else:
            print >> sys.stderr, "Line is broken: %s %s" % (cls, line)

    def run(self, filename):
        args = [self.command]
        args.extend(self.run_flags)
        args.append(filename)
        # args = " ".join(args)
        logging.debug("args: {} {}".format(args, self.env))
        process = Popen(args, stdout=PIPE, stderr=PIPE, env=self.env)
        for line in process.stdout:
            self.process_output(line)


class CompilerRunner(LintRunner):
    def run(self, filename):
        error_args = None
        try:
            compiler.parseFile(filename)
        except (SyntaxError, Exception),  e:
            error_args = e.args
        if error_args:
            self.process_output(filename, error_args)

    @classmethod
    def process_output(cls, filename, args):
        fixed_data = dict.fromkeys(('level', 'error_type',
                                    'error_number', 'description',
                                    'filename', 'line_number'),
                                   '')
        fixed_data['level'] = 'ERROR'
        fixed_data['line_number'] = args[1][1]
        fixed_data['filename'] = filename
        fixed_data['description'] = args[0]

        print cls.output_format % fixed_data


class PylintRunner(LintRunner):
    """ Run pylint, producing flymake readable output.
    The raw output looks like:
      render.py:49: [C0301] Line too long (82/80)
      render.py:1: [C0111] Missing docstring
      render.py:3: [E0611] No name 'Response' in module 'werkzeug'
      render.py:32: [C0111, render] Missing docstring
      jutils.py:859: [C0301] Line too long (107/80)"""
    output_matcher = re.compile(
        r'(?P<filename>[^:]+):'
        r'(?P<line_number>\d+):'
        r'\s\[(?P<error_type>[WECR])(?P<error_number>[\d]+.+?\])'
        r'\s*(?P<description>.*)$')
    command = PYLINT_COMMAND
    sane_default_ignore_codes = set([
        "C0103",  # Naming convention
        "C0301",  # Line too long (%s/%s)
        "C0111",  # Missing Docstring
        "E1002",  # Use super on old-style class
        "W0232",  # No __init__
        #"I0011",  # Warning locally suppressed using disable-msg
        #"I0012",  # Warning locally suppressed using disable-msg
        #"W0511",  # FIXME/TODO
        #"W0142",  # *args or **kwargs magic.
        "R0904",  # Too many public methods
        "R0903",  # Too few public methods
        "R0201",  # Method could be a function
        "W0141",  # Used built in function map
        "F0401",  # Unable to import %r (%s)
        ])

    @staticmethod
    def fixup_data(_line, data):
        if data['error_type'].startswith('E'):
            data['level'] = 'ERROR'
        else:
            data['level'] = 'WARNING'
        return data

    @property
    def run_flags(self):
        return ('--output-format', 'parseable',
                '--include-ids', 'y',
                '--reports', 'n',
                # '--disable-msg=' + ','.join(self.operative_ignore_codes))
                '-d', ','.join(self.operative_ignore_codes))


class PycheckerRunner(LintRunner):
    """ Run pychecker, producing flymake readable output.
    The raw output looks like:
      render.py:49: Parameter (maptype) not used
      render.py:49: Parameter (markers) not used
      render.py:49: Parameter (size) not used
      render.py:49: Parameter (zoom) not used """
    command = PYCHECKER_COMMAND
    output_matcher = re.compile(
        r'(?P<filename>[^:]+):'
        r'(?P<line_number>\d+):'
        r'\s+(?P<description>.*)$')

    @staticmethod
    def fixup_data(_line, data):
        #XXX: doesn't seem to give the level
        data['level'] = 'WARNING'
        return data

    @property
    def run_flags(self):
        return '--no-deprecated', '--only', '-#0'


class Pep8Runner(LintRunner):
    """ Run pep8.py, producing flymake readable output.
    The raw output looks like:
      spiders/structs.py:3:80: E501 line too long (80 characters)
      spiders/structs.py:7:1: W291 trailing whitespace
      spiders/structs.py:25:33: W602 deprecated form of raising exception
      spiders/structs.py:51:9: E301 expected 1 blank line, found 0 """
    command = PEP8_COMMAND
    # sane_default_ignore_codes = set([
    #     'RW29', 'W391',
    #     'W291', 'WO232'])
    output_matcher = re.compile(
        r'(?P<filename>[^:]+):'
        r'(?P<line_number>[^:]+):'
        r'[^:]+:'
        r' (?P<error_number>\w+) '
        r'(?P<description>.+)$')

    @staticmethod
    def fixup_data(_line, data):
        data['level'] = 'WARNING'
        return data

    @property
    def run_flags(self):
        return '--repeat'


class PyflakesRunner(LintRunner):
    """ Run pyflakes, producing flymake readable output.
    The raw output looks like:
    ./milo/models/cck.py:47: 'env' imported but unused
    ./milo/models/cck.py:51: 'dbutils' imported but unused
    ./milo/models/cck.py:1217: undefined name 'CrawlReadinessException'
    ./milo/models/cck.py:1221: undefined name 'CrawlReadinessException'
    ./milo/models/cck.py:1224: undefined name 'magicnames'
    ./milo/models/cck.py:1226: undefined name 'CrawlReadinessException'
    ./milo/models/cck.py:1227: undefined name 'magicnames'
    ./milo/models/cck.py:1231: undefined name 'CrawlReadinessException'
    ./milo/models/cck.py:1236: undefined name 'CrawlReadinessException'
    ./milo/models/cck.py:1240: undefined name 'CrawlReadinessException'
    ./milo/models/cck.py:1247: undefined name 'CrawlReadinessException'
    ./milo/models/cck.py:1976: undefined name 'extractor'
    """
    command = PYFLAKES_COMMAND

    output_matcher = re.compile(
        r'(?P<filename>[^:]+):'
        r'(?P<line_number>[^:]+):'
        r'(?P<description>.+)$')

    @staticmethod
    def fixup_data(_line, data):
        data['level'] = 'ERROR'
        return data


def main():
    from optparse import OptionParser
    parser = OptionParser()
    parser.add_option("-e", "--virtualenv",
                      dest="virtualenv",
                      default=None,
                      help="virtualenv directory")
    parser.add_option("-i", "--ignore_codes",
                      dest="ignore_codes",
                      default=(),
                      help="error codes to ignore")
    options, args = parser.parse_args()

    for runnerclass in (
            Pep8Runner,
            PylintRunner,
            #PycheckerRunner,
            # PyflakesRunner,
            # CompilerRunner
    ):
        runner = runnerclass(virtualenv=options.virtualenv,
                             ignore_codes=options.ignore_codes)
        try:
            runner.run(args[0])
        except Exception, e:
            logging.debug(traceback.format_exc(e))
            #print >> sys.stdout, '{0} FAILED'.format(runner)
            print 'ERROR : {0} failed to run at {1} line 1.'.format(
                runner.__class__.__name__, args[0])


if __name__ == '__main__':
    main()




# There is also a list of all messages sorted alphabetically by message.
# C0102: Black listed name "%s"
# C0103: Invalid name "%s" (should match %s)
# C0111: Missing docstring
# C0112: Empty docstring
# C0121: Missing required attribute "%s"
# C0202: Class method should have "cls" as first argument
# C0203: Metaclass method should have "mcs" as first argument
# C0301: Line too long (%s/%s)
# C0302: Too many lines in module (%s)
# C0321: More than one statement on a single line
# C0322: Operator not preceded by a space
# C0323: Operator not followed by a space
# C0324: Comma not followed by a space
# E0001 (syntax error raised for a module)
# E0011: Unrecognized file option %r
# E0012: Bad option value %r
# E0100: __init__ method is a generator
# E0101: Explicit return in __init__
# E0102: %s already defined line %s
# E0103: %r not properly in loop
# E0104: Return outside function
# E0105: Yield outside function
# E0106: Return with argument inside generator
# E0202: An attribute inherited from %s hide this method
# E0203: Access to member %r before its definition line %s
# E0211: Method has no argument
# E0213: Method should have "self" as first argument
# E0221: Interface resolved to %s is not a class
# E0222: Missing method %r from %s interface
# E0501: Non ascii characters found but no encoding specified (PEP 263)
# E0502: Wrong encoding specified (%s)
# E0503: Unknown encoding specified (%s)
# E0601: Using variable %r before assignment
# E0602: Undefined variable %r
# E0611: No name %r in module %r
# E0701: Bad except clauses order (%s)
# E0702: Raising %s while only classes, instances or string are allowed
# E0710: Raising a new style class which doesn't inherit from BaseException
# E1001: Use __slots__ on an old style class
# E1002: Use super on an old style class
# E1003: Bad first argument %r given to super class
# E1101: %s %r has no %r member
# E1102: %s is not callable
# E1103: %s %r has no %r member (but some types could not be inferred)
# E1111: Assigning to function call which doesn't return
# F0001 (error prevented analysis)
# F0002: %s: %s
# F0003: ignored builtin module %s
# F0004: unexpected infered value %s
# F0202: Unable to check methods signature (%s / %s)
# F0220: failed to resolve interfaces implemented by %s (%s)
# F0321: Format detection error in %r
# F0401: Unable to import %r (%s)
# I0001: Unable to run raw checkers on built-in module %s
# I0010: Unable to consider inline option %r
# I0011: Locally disabling %s
# I0012: Locally enabling %s
# I0013: Ignoring entire file
# R0001: Messages by category
# R0002: % errors / warnings by module
# R0003: Messages
# R0004: Global evaluation
# R0101: Statistics by type
# R0201: Method could be a function
# R0401: Cyclic import (%s)
# R0401: External dependencies
# R0402: Modules dependencies graph
# R0701: Raw metrics
# R0801: Duplication
# R0801: Similar lines in %s files
# R0901: Too many ancestors (%s/%s)
# R0902: Too many instance attributes (%s/%s)
# R0903: Too few public methods (%s/%s)
# R0904: Too many public methods (%s/%s)
# R0911: Too many return statements (%s/%s)
# R0912: Too many branches (%s/%s)
# R0913: Too many arguments (%s/%s)
# R0914: Too many local variables (%s/%s)
# R0915: Too many statements (%s/%s)
# R0921: Abstract class not referenced
# R0922: Abstract class is only referenced %s times
# R0923: Interface not implemented
# W0101: Unreachable code
# W0102: Dangerous default value %s as argument
# W0104: Statement seems to have no effect
# W0105: String statement has no effect
# W0107: Unnecessary pass statement
# W0108: Lambda may not be necessary
# W0122: Use of the exec statement
# W0141: Used builtin function %rW0142: Used * or ** magic
# W0201: Attribute %r defined outside __init__
# W0211: Static method with %r as first argument
# W0212: Access to a protected member %s of a client class
# W0221: Arguments number differs from %s method
# W0222: Signature differs from %s method
# W0223: Method %r is abstract in class %r but is not overridden
# W0231: __init__ method from base class %r is not called
# W0232: Class has no __init__ method
# W0233: __init__ method from a non direct base class %r is called
# W0301: Unnecessary semicolon
# W0311: Bad indentation. Found %s %s, expected %s
# W0312: Found indentation with %ss instead of %ss
# W0331: Use of the <> operator
# W0332: Use l as long integer identifier
# W0333: Use of the `` operator
# W0401: Wildcard import %s
# W0402: Uses of a deprecated module %r
# W0403: Relative import %r
# W0404: Reimport %r (imported line %s)
# W0406: Module import itself
# W0410: __future__ import is not the first non docstring statement
# W0511 (warning notes in code comments)
# W0601: Global variable %r undefined at the module level
# W0602: Using global for %r but no assigment is done
# W0603: Using the global statement
# W0604: Using the global statement at the module level
# W0611: Unused import %s
# W0612: Unused variable %r
# W0613: Unused argument %r
# W0614: Unused import %s from wildcard import
# W0621: Redefining name %r from outer scope (line %s)
# W0622: Redefining built-in %r
# W0631: Using possibly undefined loop variable %r
# W0701: Raising a string exception
# W0702: No exception type(s) specified
# W0703: Catch "Exception"
# W0704: Except doesn't do anything
# W0710: Exception doesn't inherit from standard "Exception" class
# W1001: Use of "property" on an old style class
# W1111: Assigning to function call which only returns None

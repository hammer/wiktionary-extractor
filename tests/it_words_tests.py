from nose.tools import *
from it_words import verb

def setup():
  print("SETUP!")

def teardown():
  print("TEAR DOWN!")

def test_irregularity_re():
  verb.IRREGULARITY_RE.match("prem1s").groups() == ('prem', '1', 's', '')


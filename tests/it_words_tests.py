from nose.tools import *
from it_words import verb

def test_irregularity_re():
  assert verb.IRREGULARITY_RE.match("prem1s").groups() == ('prem', '1', 's', '')

@raises(Exception)
def test_supported_verb_types():
  verb.Verb('stem', 'type')




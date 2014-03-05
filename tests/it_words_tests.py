from nose.tools import *
from it_words import verb

def test_irregularity_re():
  assert verb.IRREGULARITY_RE.match("prem1s").groups() == ('prem', '1', 's', '')

def test_is_reflexive():
  assert verb.Verb("alz", "arsi").is_reflexive
  assert not verb.Verb("alz", "are").is_reflexive

@raises(Exception)
def test_supported_verb_types():
  verb.Verb('stem', 'type')




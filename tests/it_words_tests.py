from it_words import verb

def test_irregularity_re():
  verb.IRREGULARITY_RE.match("prem1s").groups() == ('prem', '1', 's', '')


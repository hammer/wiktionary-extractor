# TODO(hammer): implement "alts" support

INFLECTION_CATEGORIES = ['are', 'arsi',
                         'care', 'carsi',
                         'gare', 'garsi',
                         'ere', 'ersi',
                         'ire-b', 'irsi-b',
                         'ire', 'irsi',
                         'iare', 'iarsi',
                         'ciare', 'ciarsi',
                         'giare', 'giarsi',
                         'urre', 'ursi',
                         'fare']

VERB_MEMBERS = ['inf', 'ger', 'par','pp']

REFLEXIVITY = [True, False]
TENSES = ['pres', 'imperf', 'prem', 'fut', 'cond', 'cong', 'imp']
PERSONS = [1, 2, 3]
NUMBERs = ['s', 'p']

class Verb:
  def __init__(self, inf, stem, type, aus, extended_info):
    self.inf = inf # TODO(hammer): pull from extended_info?
    self.stem = stem
    self.type = type
    self.aus = aus
    self.extended_info = extended_info
    for (k, v) in extended_info.items():
      pass

  def __repr__(self):
    return('Verb(%s)' % ','.join([self.inf, self.stem, self.type,
                                  self.aus, str(self.extended_info)]))

  def __str__(self):
    return(self.inf)

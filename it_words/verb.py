# TODO(hammer): implement "alts" support

INFLECTION_CATEGORIES = ['are', 'arsi',
                         'ere', 'ersi',
                         'ire', 'irsi',
                         'ire-b', 'irsi-b',
                         'care', 'carsi',
                         'gare', 'garsi',
                         'iare', 'iarsi',
                         'ciare', 'ciarsi',
                         'giare', 'giarsi',
                         'urre', 'ursi']

VERB_MEMBERS = ['inf', 'ger', 'par', 'pp']

REFLEXIVITY = [True, False]
TENSES = ['pres', 'imperf', 'prem', 'fut', 'cond', 'cong', 'imp']
PERSONS = [1, 2, 3]
NUMBERs = ['s', 'p']

ENDINGS = {
  'are': {
    'pres': ['o', 'i', 'a', 'iamo', 'ate', 'ano'],
    'imperf': ['avo', 'avi', 'ava', 'avamo', 'avate', 'avano'],
    'prem': ['ai', 'asti', 'ò', 'ammo', 'aste', 'arono'],
    'fut': ['erò', 'erai', 'erà', 'eremo', 'erete', 'eranno'],
    'cond': ['erei', 'eresti', 'erebbe', 'eremmo', 'ereste', 'erebbero'],
    'cong': ['i', 'i', 'i', 'iamo', 'iate', 'ino'],
    'congimp': ['assi', 'assi', 'asse', 'assimo', 'aste', 'assero'],
    'imp': ['', 'a', 'i', 'iamo', 'ate', 'ino']
  },
  'ere': {
    'pres': ['o', 'i', 'e', 'iamo', 'ete', 'ono'],
    'imperf': ['evo', 'evi', 'eva', 'evamo', 'evate', 'evano'],
    'prem': ['ei', 'esti', 'ette', 'é', 'emmo', 'este', 'ettero'],
    'fut': ['erò', 'erai', 'erà', 'eremo', 'erete', 'eranno'],
    'cond': ['erei', 'eresti', 'erebbe', 'eremmo', 'ereste', 'erebbero'],
    'cong': ['a', 'a', 'a', 'iamo', 'iate', 'ano'],
    'congimp': ['essi', 'essi', 'esse', 'essimo', 'este', 'essero'],
    'imp': ['', 'i', 'i', 'iamo', 'ete', 'ano']
  },
  'ire': {
    'pres': ['o', 'i', 'e', 'iamo', 'ite', 'ono'],
    'imperf': ['ivo', 'ivi', 'iva', 'ivamo', 'ivate', 'ivano'],
    'prem': ['ii', 'isti', 'ì', 'immo', 'iste', 'irono'],
    'fut': ['irò', 'irai', 'irà', 'iremo', 'irete', 'iranno'],
    'cond': ['irei', 'iresti', 'irebbe', 'iremmo', 'ireste', 'irebbero'],
    'cong': ['a', 'a', 'a', 'iamo', 'iate', 'ano'],
    'congimp': ['issi', 'issi', 'isse', 'issimo', 'iste', 'issero'],
    'imp': ['', 'i', 'a', 'iamo', 'ite', 'ano']
  }
}

ENDINGS['ire-b'] = dict([(tense,
                          ['isc' + ending if i in [0, 1, 2, 5] else ending
                           for (i, ending) in enumerate(endings)]
                          if tense in ['pres', 'cong', 'imp'] else endings)
                         for (tense, endings)
                         in ENDINGS['ire'].items()])

class Verb:
  def __init__(self, stem, type, aus='avere', extended_info=None):
    self.stem = stem
    self.type = type
    self.aus = aus
    self.extended_info = extended_info

    # Derived members
    base_type = type.split('-')[0]
    self.is_reflexive = base_type.endswith('si')
    self.inf = stem + base_type
    self.conjugations = dict([(tense, [stem + ending for ending in endings])
                              for (tense, endings)
                              in ENDINGS[type].items()])

  def __repr__(self):
    return('Verb(%s)' % ','.join([self.inf, self.stem, self.type,
                                  self.aus, str(self.extended_info)]))

  def __str__(self):
    return(self.inf)

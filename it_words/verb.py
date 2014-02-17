# TODO(hammer): implement "alts" support
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
    'prem': ['ei', 'esti', 'é', 'emmo', 'este', 'erono'],
    'fut': ['erò', 'erai', 'erà', 'eremo', 'erete', 'eranno'],
    'cond': ['erei', 'eresti', 'erebbe', 'eremmo', 'ereste', 'erebbero'],
    'cong': ['a', 'a', 'a', 'iamo', 'iate', 'ano'],
    'congimp': ['essi', 'essi', 'esse', 'essimo', 'este', 'essero'],
    'imp': ['', 'i', 'a', 'iamo', 'ete', 'ano']
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
                          ['isc' + ending
                           if ending in ['a', 'e', 'i', 'o', 'ano', 'ono']
                           else ending
                           for ending in endings])
                         for (tense, endings)
                         in ENDINGS['ire'].items()])

ENDINGS['care'] = dict([(tense,
                         ['h' + ending if ending.startswith(('e', 'i')) else ending
                          for ending in endings])
                         for (tense, endings)
                         in ENDINGS['are'].items()])
ENDINGS['gare'] = ENDINGS['care']

ENDINGS['iare'] = dict([(tense, [ending.lstrip('i') for ending in endings])
                         for (tense, endings)
                         in ENDINGS['are'].items()])

ENDINGS['ciare'] = dict([(tense,
                          ['i' + ending.lstrip('i')
                           if not ending.startswith('e')
                           else ending
                           for ending in endings])
                         for (tense, endings)
                         in ENDINGS['are'].items()])
ENDINGS['giare'] = ENDINGS['ciare']

ENDINGS['urre'] = dict([(tense,
                         ['ur' + ending.lstrip('e')
                          if ending.startswith('er')
                          else 'uc' + ending
                          for ending in endings])
                        for (tense, endings)
                        in ENDINGS['ere'].items()
                        if tense != 'prem'])
ENDINGS['urre']['prem'] = ['ussi', 'ucesti', 'usse', 'ucemmo', 'uceste', 'ussero']

# Reflexive
for type in ['are', 'ere', 'ire', 'care', 'gare', 'iare', 'ciare', 'giare', 'urre', 'ire-b']:
  if type == 'ire-b':
    reflexive_type = 'irsi-b'
  elif type == 'urre':
    reflexive_type = 'ursi'
  else:
    reflexive_type = type[:-1] + 'si'

  ENDINGS[reflexive_type] = ENDINGS[type]
  suffixes = ['', 'ti', '', 'ci', 'vi', '']
  ENDINGS[reflexive_type]['imp'] = [''.join([ending, suffix])
                                    for (ending, suffix)
                                    in zip(ENDINGS[type]['imp'], suffixes)]

# TODO(hammer): make this class immutable
class Verb:
  def __init__(self, stem, type, aus='avere', extended_info=None):
    # TODO(hammer): check for data quality here
    if type not in ENDINGS.keys():
      pass

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

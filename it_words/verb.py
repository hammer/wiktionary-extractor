# TODO(hammer): implement compound tense support
# TODO(hammer): implement "alts" support
import re
import string

# TODO(hammer): replace use of string module with character classes
IRREGULARITY_RE = re.compile('^(['+string.ascii_letters+']*)(['+string.digits+']*)(['+string.ascii_letters+']*)(['+string.digits+']*)$')
NO_TENSE = ['inf', 'ger', 'par', 'pp']

ENDINGS = {
  'are': {
    'no_tense': ['are', 'ando', 'ante', 'ato'],
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
    'no_tense': ['ere', 'endo', 'ente', 'uto'],
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
    'no_tense': ['ire', 'endo', 'ente', 'ito'],
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
                        if tense not in ['no_tense', 'prem']])
ENDINGS['urre']['no_tense'] = ['urre', 'ucendo', 'ucente', 'otto']
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

  ENDINGS[reflexive_type]['no_tense'] = \
      [reflexive_type.split('-')[0]] + \
      [ending + 'si' for ending in ENDINGS[type]['no_tense'][1:]]


# TODO(hammer): make this class immutable
class Verb:
  def __init__(self, stem, type, aus='avere', extended_info=None):
    # TODO(hammer): check for data quality here and raise a better Exception
    if type not in ENDINGS.keys():
      raise(Exception)

    self.stem = stem
    self.type = type
    self.aus = aus
    self.extended_info = extended_info

    # Derived members
    base_type = type.split('-')[0]
    self.is_reflexive = base_type.endswith('si')
    self.conjugations = dict([(tense, [stem + ending for ending in endings])
                              for (tense, endings)
                              in ENDINGS[type].items()])
    if self.is_reflexive:
      prefixes = ['mi', 'ti', 'si', 'ci', 'vi', 'si']
      self.conjugations.update(dict([(tense, [' '.join([prefix, word])
                                              for (prefix, word)
                                              in zip(prefixes, words)])
                                     for (tense, words)
                                     in self.conjugations.items()
                                     if tense not in ['no_tense', 'imp']]))

    # Irregularities
    for (k, v) in extended_info.items():
      try:
        word1, number1, word2, number2 = IRREGULARITY_RE.match(k).groups()
        if word1 in NO_TENSE:
          if number1: pass # TODO(hammer): handle alts
          self.conjugations['no_tense'][NO_TENSE.index(word1)] = v
        else:
          if number2: pass # TODO(hammer): handle alts
          for person in number1:
            index = (int(person) - 1) + 3 * (1 if word2 == 'p' else 0)
            self.conjugations[word1][index] = v
      except:
        pass

    self.inf = self.conjugations['no_tense'][0]

  def __repr__(self):
    return('Verb(%s)' % ','.join([self.inf, self.stem, self.type, self.aus]))

  def __str__(self):
    return(self.inf)

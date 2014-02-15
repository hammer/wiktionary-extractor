#! /usr/bin/env python3
from itertools import takewhile
import re

from lxml import etree

INFLECTION_CATEGORIES = ['are', 'arsi',
                         'care', 'carsi',
                         'ciare', 'ciarsi',
                         'gare', 'giare',
                         'iare',
                         'ere', 'ersi',
                         'ire', 'ire-b',
                         'urre']

class Verb:
  def __init__(self, infinitive, stem, inflection_category, auxiliary_verb, extended_info):
    self.infinitive = infinitive
    self.stem = stem
    self.inflection_category = inflection_category
    self.auxiliary_verb = auxiliary_verb
    self.extended_info = extended_info

  def __repr__(self):
    return('Verb(%s)' % ','.join([self.infinitive, self.stem, self.inflection_category,
                                  self.auxiliary_verb, str(self.extended_info)]))

  def __str__(self):
    return(self.infinitive)


WIKTIONARY_XML_FILE=''

# TODO(hammer) compile the XPath queries that are run more than once
XPATH_PAGE = '/mw:mediawiki/mw:page'
XPATH_PAGE_TITLE = 'mw:title/text()'
XPATH_PAGE_NS = 'mw:ns/text()'
XPATH_PAGE_ID = 'mw:id/text()'
XPATH_PAGE_CONTENT = 'mw:revision/mw:text/text()'
MEDIAWIKI_NS = {'mw': 'http://www.mediawiki.org/xml/export-0.8/'}
IT_PREFIX = '== {{-it-}} =='
WIKILINKS_RE = re.compile('\[\[(.*?)\]\]')

def xpath_ns(element, xpath_query):
  return element.xpath(xpath_query,
                       namespaces=MEDIAWIKI_NS,
                       smart_strings=False)

# TODO(hammer): do this with smc.mw and XPath?
# Used to parse synonym and antonym lists
def parse_list(wiki_markup, list_marker):
  lines = wiki_markup.split('\n')
  try:
    i = lines.index(list_marker)
  except ValueError:
    return [[]]

  return [WIKILINKS_RE.findall(line)
          for line
          in takewhile(lambda line: line.startswith('*'), lines[i+1:])]

# TODO(hammer): create a Verb class to capture this complexity
def parse_verb(wiki_markup):
  # TODO(hammer): probably prettier to do this with a regex
  try:
    conj = wiki_markup.split('conj/Test')[1].split('}}')[0].strip().split('|')[1:]
  except:
    return [], {}

  # Bug in ["contendere", "rompere"] markup; fixed on wiki, need to wait for next dump
  if conj[0] in ['contend', 'romp']:
    return [], {}

  # TODO(hammer): fix venire, ciurmare, dirimere, etc. on wiki (need to use templates)

  # NB: this would be a lot prettier if we had lfold and pattern matching
  base_info = []
  extended_info = []
  for item in conj:
    item = item.strip()
    if '=' in item:
      extended_info.append(tuple(item.split('=')))
    else:
      base_info.append(item)
  return base_info, dict(extended_info)


if __name__ == '__main__':
  root = etree.parse(WIKTIONARY_XML_FILE)

  # TODO(hammer): better with XSLT or an XQuery library?
  pages = [(xpath_ns(page, XPATH_PAGE_TITLE)[0],
                 xpath_ns(page, XPATH_PAGE_NS)[0],
                 xpath_ns(page, XPATH_PAGE_ID)[0],
                 xpath_ns(page, XPATH_PAGE_CONTENT)[0])
                for page in xpath_ns(root, XPATH_PAGE)
                if len(xpath_ns(page, XPATH_PAGE_CONTENT)) > 0]
  it_words = [page for page in pages
              if page[1] == '0' and page[3].startswith('== {{-it-}} ==')]
  it_verbs = [page for page in pages
              if page[1] != '0' and page[0].startswith('Appendice:Coniugazioni/Italiano/')]

  print('Found %d italian words and %d conjugated verbs.' % (len(it_words), len(it_verbs)))

  # URL base http://it.wiktionary.org/wiki
  with open('it_words.csv', 'w') as ofile:
    ofile.write('\n'.join([page[0] for page in it_words]))

  # URL base http://it.wiktionary.org/wiki/Appendice:Coniugazioni/Italiano
  with open('it_verbs.csv', 'w') as ofile:
    to_write = []
    for page in it_verbs:
      base_info, extended_info = parse_verb(page[3])
      if len(base_info) == 3:
        to_write.append(':'.join([page[0],
                                  Verb(page[0].split('/')[-1], base_info[0], base_info[1],
                                       base_info[2], extended_info).__repr__()]))
      else:
        to_write.append(':'.join([page[0], ';'.join([str(base_info), str(extended_info)])]))
    ofile.write('\n'.join(to_write))

  # Pull out lists from page text (in markup)
  synonyms = [(page[0], parse_list(page[3], '{{-sin-}}')) for page in it_words]
  with open('synonyms.csv', 'w') as ofile:
    ofile.write('\n'.join([' '.join([word[0], ';'.join([','.join(synonym) for synonym in word[1]])])
                           for word in synonyms]))

  antonyms = [(page[0], parse_list(page[3], '{{-ant-}}')) for page in it_words]
  with open('antonyms.csv', 'w') as ofile:
    ofile.write('\n'.join([' '.join([word[0], ';'.join([','.join(antonym) for antonym in word[1]])])
                           for word in antonyms]))

#! /usr/bin/env python3
from itertools import takewhile
import re

from lxml import etree

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
def parse_list(wiki_markup, list_marker):
  lines = wiki_markup.split('\n')
  try:
    i = lines.index(list_marker)
  except ValueError:
    return [[]]

  return [WIKILINKS_RE.findall(line)
          for line
          in takewhile(lambda line: line.startswith('*'), lines[i+1:])]


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
              if page[1] != '0' and page[0].startswith('Appendice:Coniugazioni/Italiano')]

  print('Found %d italian words and %d conjugated verbs.' % (len(it_words), len(it_verbs)))

  # URL base http://it.wiktionary.org/wiki
  with open('it_words.csv', 'w') as ofile:
    ofile.write('\n'.join([page[0].lower() for page in it_words]))

  # URL base http://it.wiktionary.org/wiki/Appendice:Coniugazioni/Italiano
  with open('it_verbs.csv', 'w') as ofile:
    ofile.write('\n'.join([page[0].lower() for page in it_verbs]))

  # Pull out lists from page text (in markup)
  synonyms = [(page[0], parse_list(page[3], '{{-sin-}}')) for page in it_words]
  with open('synonyms.csv', 'w') as ofile:
    ofile.write('\n'.join([' '.join([word[0], ';'.join([','.join(synonym) for synonym in word[1]])])
                           for word in synonyms]))

  antonyms = [(page[0], parse_list(page[3], '{{-ant-}}')) for page in it_words]
  with open('antonyms.csv', 'w') as ofile:
    ofile.write('\n'.join([' '.join([word[0], ';'.join([','.join(antonym) for antonym in word[1]])])
                           for word in antonyms]))

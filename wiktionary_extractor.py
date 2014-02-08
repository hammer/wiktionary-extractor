#! /usr/bin/env python3

from lxml import etree

WIKTIONARY_XML_FILE=''

# TODO(hammer) compile the XPath queries that are run more than once
XPATH_PAGE = '/mw:mediawiki/mw:page[mw:ns=0]'
XPATH_PAGE_TITLE = 'mw:title/text()'
XPATH_PAGE_ID = 'mw:id/text()'
XPATH_PAGE_CONTENT = 'mw:revision/mw:text/text()'
MEDIAWIKI_NS = {'mw': 'http://www.mediawiki.org/xml/export-0.8/'}
IT_PREFIX = '== {{-it-}} =='

def xpath_ns(element, xpath_query):
  return element.xpath(xpath_query,
                       namespaces=MEDIAWIKI_NS,
                       smart_strings=False)

if __name__ == '__main__':
  root = etree.parse(WIKTIONARY_XML_FILE)
  # TODO(hammer): better with XSLT or an XQuery library?
  pages = [(xpath_ns(page, XPATH_PAGE_TITLE)[0],
            xpath_ns(page, XPATH_PAGE_ID)[0],
            xpath_ns(page, XPATH_PAGE_CONTENT)[0])
           for page in xpath_ns(root, XPATH_PAGE)
           if len(xpath_ns(page, XPATH_PAGE_CONTENT)) > 0]
  it_pages = [page for page in pages if page[2].startswith('== {{-it-}} ==')]

  print('Found %d pages and %d italian pages.' % (len(pages), len(it_pages)))

  with open('it_wiktionary_pages.csv', 'w') as ofile:
    ofile.write('\n'.join([page[0].lower() for page in it_pages]))





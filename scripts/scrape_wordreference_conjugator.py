import argparse
import logging
from lxml import html
import re
import requests
import sys

XPATH_NO_TENSE = '//td[starts-with(@title, "infinitive")]/following-sibling::td'
XPATH_PRES = '//th[@title="Indicative"]/../following-sibling::tr[2]/td[2]'
RE_TD = re.compile('<td.*?>(.*?)</td>', re.DOTALL)

WORDREFERENCE_CONJUGATOR_URL_BASE = 'http://www.wordreference.com/conj/ItVerbs.aspx?v='

def get_element_from_xpath(xpath, html_fragment):
  return html.fromstring(html_fragment).xpath(xpath)[0]

def get_list_from_td_element(td_el):
    outerHTML = html.tostring(td_el, encoding='UNICODE')
    innerHTML = RE_TD.search(outerHTML).groups()[0].strip()
    return [word.replace('<b>', '').replace('</b>', '').strip()
            for word in innerHTML.split('<br>')]

if __name__ == '__main__':
  parser = argparse.ArgumentParser(description='Scrape verb conjugations from Wordreference.')
  parser.add_argument('verb_file', help='a newline-separated list of verbs')
  parser.add_argument('-v', '--verbose', action='store_true')

  args = parser.parse_args()
  if args.verbose: logging.basicConfig(level=logging.DEBUG)
  verbs_file = args.verb_file

  with open(verbs_file, 'rt') as infile:
    verbs = [line.strip() for line in infile.readlines()]

  for verb in verbs:
    # Wordreference can't conjugate it!
    if verb in ['delinquere', 'ire', 'gire', 'soccombere']:
      continue

    logging.info("Processing %s\n" % verb)
    r = requests.get(WORDREFERENCE_CONJUGATOR_URL_BASE + verb)
    verb_html = r.content

    # no_tense
    no_tense_td_el = get_element_from_xpath(XPATH_NO_TENSE, verb_html)
    logging.info(html.tostring(no_tense_td_el))
    no_tense = get_list_from_td_element(no_tense_td_el)
    logging.info(no_tense)

    # pres
    pres_td_el = get_element_from_xpath(XPATH_PRES, verb_html)
    pres = get_list_from_td_element(pres_td_el)
    logging.info(pres)


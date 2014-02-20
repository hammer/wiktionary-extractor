from setuptools import setup

setup(
    name='wiktionary-extractor',
    version='0.1',
    long_description=__doc__,
    packages=['it_words'],
    scripts=['scripts/wiktionary_extractor.py',
             'scrape_wordreference_conjugator.py'],
    zip_safe=False,
    install_requires=['lxml']
)


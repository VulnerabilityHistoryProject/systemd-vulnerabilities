from typing import OrderedDict
import ruamel
from ruamel.yaml import YAML
from ruamel.yaml.representer import RoundTripRepresenter
import sys
import os

yaml=YAML(pure=True )   # default, if not specfied, is 'rt' (round-trip)

class MyRepresenter(RoundTripRepresenter):
    pass

ruamel.yaml.add_representer(OrderedDict, MyRepresenter.represent_dict, 
                            representer=MyRepresenter)

YAML.Representer = MyRepresenter

with open('skeletons/cve.yml') as f: 
    # print(f.read())
    h = yaml.load(f)
    print(yaml.dump(h, sys.stdout))

# for entry in os.scandir('cves/'):

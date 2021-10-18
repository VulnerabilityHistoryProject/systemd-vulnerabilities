from typing import OrderedDict
import ruamel
from ruamel.yaml import YAML
from ruamel.yaml.representer import RoundTripRepresenter
import sys
import os

yaml=YAML(pure=True)   # default, if not specfied, is 'rt' (round-trip)

class MyRepresenter(RoundTripRepresenter):
    pass

ruamel.yaml.add_representer(OrderedDict, MyRepresenter.represent_dict, 
                            representer=MyRepresenter)

YAML.Representer = MyRepresenter
with open(r'skeletons/cve.yml', 'r') as skel_file:
    skel = yaml.load(skel_file)

skel_keys = list(skel.keys())
keys_to_keep = "fixes vccs CVE".split()

for entry in os.scandir(r'cves/'):
    with open(entry.path, 'r') as f: 
        h = yaml.load(f)
    for key in skel_keys:
        if key not in keys_to_keep:  
            h[key] = skel[key]
    with open(entry.path, 'w') as f: 
        print(yaml.dump(h, f))

import json

from pprint import pprint

with open('*.json') as file:
    data = json.load(file)

pprint(data)
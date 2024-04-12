# open terminal in schemasProject top-level!

import requests
import json

response = requests.get("http://digitalcollections.lib.washington.edu/digital/bl/dmwebservices/index.php?q=dmGetCollectionList/json")
with open('json/collection_list.json', 'w+') as jsonfile:
    jsonfile.write(response.text)
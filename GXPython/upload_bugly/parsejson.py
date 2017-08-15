__author__ = 'ZhaoMin'

import sys
import json
from collections import namedtuple

data = sys.argv[1]

# Parse JSON into an object with attributes corresponding to dict keys.
x = json.loads(data, object_hook=lambda d: namedtuple('X', d.keys())(*d.values()))
print x.data.url

exit(0)

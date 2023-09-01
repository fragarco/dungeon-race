from basdev import basparser
import sys

"""
Right now we only have de feature of parsing a pseudo BAS file and 
convert it to Locomotive BAS, but we would like to add more tools
like creating a empty project ready to work, create DSK/CDT files
etc.
"""

sys.exit(basparser.parse(sys.argv))
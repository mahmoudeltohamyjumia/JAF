import os
import warnings
import base64
import curlify
from jinja2 import Template                           
from sys import stdout, __stdout__
from robot.api.deco import keyword
from jsonpath_ng import jsonpath, parse
from random import randint
from dateutil import parser
from faker import Faker

warnings.filterwarnings("ignore")

@keyword('Encode to Base64 format')
def Encode_to_Base64_format(input):
    """
    Encode the given input to Base64 format, then prepend with 'Basic ' string.

    Args:
        input (str): The string to be encoded.

    Returns:
        str: The Base64 encoded string with 'Basic ' prepended.
    """
    
    encodedBytes = base64.urlsafe_b64encode(input.encode("utf-8"))
    encodedStr = str(encodedBytes, "utf-8")
    return 'Basic '+ encodedStr

def Render_The_Template(template,**dataDict):
    """
    Renders the given Jinja2 template with the given data dictionary.

    Args:
        template (str): The Jinja2 template to be rendered.
        **dataDict: The keyword arguments are used as the data dictionary to render the template.

    Returns:
        str: The rendered template as a string.
    """
    
    tm = Template(template)
    return tm.render(dataDict, autoescape=True)

@keyword('Convert To Curl')
def convert_to_curl(r):
    """
    Convert the given requests response object to a curl command.

    Args:
        r: The requests response object to be converted.

    Returns:
        str: The curl command as a string.
    """
    data = curlify.to_curl(r)
    data = data.replace("curl -X ", "curl --location --request ")
    data = data.replace(" -H ", " --header ")
    return data

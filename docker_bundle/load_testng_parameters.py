import json
import sys
import xml.etree.ElementTree as elementTree

xml_data_tree = elementTree.parse('template.xml')

# Read TestNG input parameters from Json file
with open(sys.argv[1]) as test_ng_json_data:  # Pass json file path as script argument
    input_params = json.load(test_ng_json_data)


def update_test_ng_parameter(parameter_key, value):
    for parameter in xml_data_tree.findall('.//parameter'):
        if parameter.attrib['name'] == parameter_key:
            print('##### Updating parameter: ' + parameter.attrib['name'] + ' = ' + value + '#####')
            parameter.attrib['value'] = value
    xml_data_tree.write('testng.xml')
    return


# Update values as per user input and constructs TestNG.xml file
def create_test_ng_file():
    update_test_ng_parameter("URL", input_params['URL'])
    return

create_test_ng_file()

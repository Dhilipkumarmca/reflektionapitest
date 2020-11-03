def schema_validation(data):
    data = data.json()
    print("schema validation: ",len(data))
    should_be_list(data)
    should_be_dictionary(data[0])

def should_be_list(data):
    assert type(data).__name__ == 'list', "Data should be list"

def should_be_int(data):
    assert type(data).__name__ == 'int', "Data should be int"

def should_be_string(data):
    assert type(data).__name__ == 'str', "Data should be string"

def should_be_dictionary(data):
    assert type(data).__name__ == 'dict', "Data should be dictionary"

def should_be_equal_to(data1,data2):
    assert data1 == data2, "Failed: Status returned {} Expected {}".format(data1, data2)

def should_be_greater_than_or_equal_to(data1,data2):
    assert data1 >= data2, "Failed: data {} is less than {}".format(data1, data2)

def should_be_greater(data1,data2):
    assert data1 > data2, "Failed: data {} is less than or equal to {}".format(data1, data2)
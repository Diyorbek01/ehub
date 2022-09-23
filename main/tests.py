example = [12, 2, [2, 3, [1, 2, 3, 4]], 4, [3, 3, ], 4]
result_elements = example[0]
result_ = str(example).replace('[', '')
_result = result_.replace(']', '')
print(_result)
result = [int(x) for x in str(_result) if x.isdigit()]
print(result)

# Byte writing problem 
li = [ [7,9], [1, 3], [10, 15], [2,6]]

li.sort()
max_val = None
result = list()
for row in li:
    
    if max_val is None:
        max_val = row[1]
        result.append(row[1])
    elif max_val < row[1]:
        max_val = row[1]
        result.append(row[1])
    else:
        result.append(max_val)
        
print(result)
       
